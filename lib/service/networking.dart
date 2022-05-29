import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  static Future getData(String urlString,
      [Map<String, String>? headers]) async {
    print(urlString);
    Uri url = Uri.parse(urlString);
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode != 200) {
      print(response.statusCode);
      return;
    }

    String data = response.body;
    var decodedData = jsonDecode(data);

    print('------------------------------------------------\n'
        'Request: ${response.request} \n'
        'Status code: ${response.statusCode} \n'
        'Reason: ${response.reasonPhrase} \n'
        'Body: ${response.body} \n'
        '------------------------------------------------');

    return decodedData;
  }
}
