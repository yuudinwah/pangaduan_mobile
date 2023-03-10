import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pangaduan/commons/utils/server.dart';

class DashboardMiddleware {
  static Future<Map<String, dynamic>> fetch(String token) async {
    http.Response response =
        await http.get(dashboardAdminUrl, headers: {'token': token});
    if (response.statusCode != 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      throw (Map<String, dynamic>.from(
        body['status'] ?? {'message': 'Gagal terhubung ke server'},
      ))['message'];
    }
    Map<String, dynamic> body =
        jsonDecode(response.body) as Map<String, dynamic>;
    return Map<String, dynamic>.from(body['data']);
  }
}
