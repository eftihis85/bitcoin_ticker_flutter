import 'service/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiHeader_key = 'X-CoinAPI-Key';
const apiKey = 'BA61550A-BA17-46BD-BE18-5FA49D70FD19';

// const apiUrl = 'https://rest.coinapi.io';
// const apiParam_key = '?apikey=BA61550A-BA17-46BD-BE18-5FA49D70FD19';
// const apiPath_assets = '/v1/assets';
// const apiPath_assets_param_assetFilter = '?filter_asset_id=';

// {exchange_id}_SPOT_{asset_id_base}_{asset_id_quote}

class CoinData {
  static Future<dynamic> getCoinData(String base, String quote) async {
    String urlString = 'https://rest.coinapi.io/v1/exchangerate/'
        '$base/'
        '$quote'
        '?apikey=BA61550A-BA17-46BD-BE18-5FA49D70FD19';

    // Map<String, String> header = {apiHeader_key: apiKey};

    print(urlString);

    return await NetworkHelper.getData(urlString);
  }
}
