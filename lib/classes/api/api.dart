import 'package:http/http.dart' as http;
class Api {
  static final _api = Api._internal();

  factory Api() {
    return _api;
  }
  Api._internal();

  // static String baseUrl = ;
  static String baseUrl = "http://192.168.158.177/api/";
  String login = Api.baseUrl+"loginapi.php";
  String path = 'chat/api';
  String dataApi =Api.baseUrl+"data.php";
  String searchApi =Api.baseUrl+"searchSpecialist.php";
  String dosageApi =Api.baseUrl+"prescription.php";
  String userdataApi =Api.baseUrl+"userdata.php";
  String userchatApi =Api.baseUrl+"chatselect.php";
  String addchatApi = Api.baseUrl+"chat.php";

  Future<http.Response> httpGet(String endPath, {required Map<String, String> query}) {
    Uri uri = Uri.http(baseUrl, '$path/$endPath');
    if(query != null) {
      uri = Uri.http(baseUrl,'$path/$endPath', query);
    }
    return http.get(uri, headers: {
      'Authorization': 'Bearer $baseUrl',
      'Accept':'application/json',
    });
  }
  Future<http.Response> httpPost(String endPath, Object body) {
    Uri uri = Uri.http(baseUrl, '$path/$endPath');
    return http.post(uri, body: body, headers: {
      'Authorization': 'Bearer $baseUrl',
      'Accept':'application/json',
    });
  }
}