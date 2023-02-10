import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pangaduan/commons/utils/server.dart';

class CaseResponseMiddleware {
  static Future<List<Map<String, dynamic>>> fetch(
      String token, String caseID) async {
    http.Response response = await http.get(
        Uri.parse('${caseResponseFetchUrl.toString()}?id=$caseID'),
        headers: {'token': token});
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
    required String caseID,
    required String userID,
    required String caseResponse,
  }) async {
    http.Response response = await http.post(caseResponseAddUrl,
        body: jsonEncode({
          "caseID": caseID,
          "userID": userID,
          "response": caseResponse,
        }));
    if (response.statusCode != 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      throw (Map<String, dynamic>.from(
        body['status'] ?? {'message': 'Gagal terhubung ke server'},
      ))['message'];
    }
  }
}
