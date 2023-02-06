import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pangaduan/commons/utils/server.dart';

class AuthMiddleware {
  static Future<Map<String, dynamic>> signin(
      String email, String password) async {
    http.Response response = await http.post(authLoginUrl,
        body: jsonEncode({'email': email, 'password': password}));
    if (response.statusCode != 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      throw (Map<String, dynamic>.from(
        body['status'] ?? {'message': 'Gagal terhubung ke server'},
      ))['message'];
    }
    Map<String, dynamic> body =
        jsonDecode(response.body) as Map<String, dynamic>;
    return Map<String, dynamic>.from(body['data'] ?? {});
  }

  static Future<bool> signup(String name, String email, String password) async {
    http.Response response = await http.post(authRegisterUrl,
        body: jsonEncode({'name': name, 'email': email, 'password': password}));
    if (response.statusCode != 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      throw (Map<String, dynamic>.from(
        body['status'] ?? {'message': 'Gagal terhubung ke server'},
      ))['message'];
    }
    return true;
  }

  static Future<Map<String, dynamic>> get(String token) async {
    http.Response response =
        await http.get(authGetUrl, headers: {'token': token});
    if (response.statusCode != 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      throw (Map<String, dynamic>.from(
        body['status'] ?? {'message': 'Gagal terhubung ke server'},
      ))['message'];
    }
    Map<String, dynamic> body =
        jsonDecode(response.body) as Map<String, dynamic>;
    Map<String, dynamic> data = Map<String, dynamic>.from(body['data'] ?? {});
    return {
      'id': data['id'],
      'name': data['name'],
      'email': data['email'],
      'roles': List<String>.from(data['roles'] ?? []),
    };
  }
}
