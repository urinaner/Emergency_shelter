import 'package:http/http.dart' as http;
import 'dart:convert';

//이 클래스는 데이터를 리턴해주는 메소드
class Network {
  final String url;
  final String url2;
  final String disurl;
  Network(this.url, this.url2, this.disurl);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    print(url);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }

  Future<dynamic> getAirData() async {
    http.Response response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }

  Future<dynamic> getDisaster() async {
    http.Response response = await http.get(Uri.parse(disurl));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}
