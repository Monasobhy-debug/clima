import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final Uri url;
  var data;

  Future getData() async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
      } else
        print(response.statusCode);
    } catch (e) {
      print(e);
    }

    return data;
  }
}
