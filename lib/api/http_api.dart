import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app99/constant/constants.dart';

class HttpApi {
  static Future<http.Response?> post(String? path, {required var body}) async {
    final url = '${Constants.apiRootPath}/$path';
    final box = Hive.box('myBox');
    String? token = box.get('api_token');
    Map<String, String> headers = {};
    headers['Authorization'] = 'bearer $token';
    headers['Content-Type'] = "application/json;charset=UTF-8";
    headers['Access-Control-Allow-Origin'] = "*";
    headers['Access-Control-Allow-Origin-Credentials'] = "true";
    final uri = Uri.parse(url);
    try {
      final response = await http
          .post(uri, headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 15));

      print('HTTP RESPONSE STATUS: ${response.statusCode}');
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }

  // method get
  static Future<http.Response?> get(String? path) async {
    final url = '${Constants.apiRootPath}/$path';
    final box = Hive.box('myBox');
    String? token = box.get('api_token');
    Map<String, String> headers = {};
    headers['Authorization'] = 'bearer $token';
    headers['Content-Type'] = "application/json;charset=UTF-8";
    headers['Access-Control-Allow-Origin'] = "*";
    headers['Access-Control-Allow-Origin-Credentials'] = "true";
    final uri = Uri.parse(url);
    print('HTTP RESPONSE UR:: $url');
    try {
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 15));

      print('HTTP RESPONSE STATUS: ${response.statusCode}');
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
  static Future<http.Response?> post2(String? path,
      {required Map<String, dynamic> body}) async {
    final url = '${Constants.apiRootPath}/$path';
    final box = GetStorage();
    String? token = box.read('api_token');
    Map<String, String> headers = {};
    headers['Authorization'] = 'bearer $token';
    // headers['Content-Type'] = "application/json;charset=UTF-8";
    headers['Access-Control-Allow-Origin'] = "*";
    headers['Access-Control-Allow-Origin-Credentials'] = "true";
    final uri = Uri.parse(url);
    try {
      final response = await http
          .post(uri, headers: headers, body: body)
          .timeout(const Duration(seconds: 15));

      print('HTTP RESPONSE STATUS: ${response.statusCode}');
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
