import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:bitcoin_ticker_flutter/service/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  final priceScreen;

  PriceScreen({this.priceScreen});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String base = 'BTC';
  String quote = 'USD';
  double rate = 0.0;
  List<String> baseList = [];
  List<String> rateList = [];

  var _rateFormatted = NumberFormat('#,##0.00', 'en_US');

  @override
  void initState() {
    super.initState();
    updateUI(null);
  }

  void updateUI(dynamic coinData) {
    setState(() {
      if (coinData == null) {
        rate = 0.0;
        // String coinDataMessage = 'Unable to get weather data';
        return;
      }

      rate = coinData['rate'];
    });
  }

  List<Widget> getBaseAssetsCards() {
    List<Widget> widgetList = [];
    int order = 0;

    for (String s in cryptoList) {
      order++;
      baseList.add(s);
      widgetList.add(Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $s = ${_rateFormatted.format(rate)} $quote',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }

    return widgetList;
  }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    DropdownMenuItem<String> dropdownMenuItem;

    for (String s in currenciesList) {
      dropdownMenuItem = DropdownMenuItem(
        value: s,
        child: Text(s),
      );

      dropdownItems.add(dropdownMenuItem);
    }

    return DropdownButton<String>(
      value: quote,
      items: dropdownItems,
      onChanged: (v) {
        setState(() async {
          quote = v!;
          var coinData = await CoinData.getCoinData(base, quote);
          updateUI(coinData);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> texts = [];

    for (String s in currenciesList) {
      texts.add(Text(s));
    }

    return CupertinoPicker(
      itemExtent: 32,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (v) {
        setState(() async {
          quote = texts[v].data.toString();
          print(quote);
          var coinData = await CoinData.getCoinData(base, quote);
          updateUI(coinData);
        });
      },
      children: texts,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(children: getBaseAssetsCards()),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
