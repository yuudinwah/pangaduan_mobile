import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pangaduan/commons/utils/server.dart';

class CaseMiddleware {
  static Future<List<Map<String, dynamic>>> fetch(String token) async {
    http.Response response =
        await http.get(caseFetchUrl, headers: {'token': token});
    if (response.statusCode != 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      throw (Map<String, dynamic>.from(
        body['status'] ?? {'message': 'Gagal terhubung ke server'},
      ))['message'];
    }
    Map<String, dynamic> body =
        jsonDecode(response.body) as Map<String, dynamic>;
    return List<Map<String, dynamic>>.from(body['data']);
  }

  static Future<void> add({
    String? userID,
    required String name,
    required String email,
    required String title,
    required String detail,
  }) async {
    http.Response response = await http.post(caseAddUrl,
        body: jsonEncode({
          "userID": userID,
          "name": name,
          "email": email,
          "title": title,
          "detail": detail,
        }));
    if (response.statusCode != 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      throw (Map<String, dynamic>.from(
        body['status'] ?? {'message': 'Gagal terhubung ke server'},
      ))['message'];
    }
  }
}
