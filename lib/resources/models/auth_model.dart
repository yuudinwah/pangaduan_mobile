import 'package:pangaduan/commons/utils/pref.dart';
import 'package:pangaduan/resources/middlewares/auth_middleware.dart';
import 'package:pangaduan/resources/models/user_model.dart';

class AuthModel {
  String? token;
  DateTime? expiredAt;
  bool isLogin = false;
  UserModel? user;

  Future<void> signin(String email, String password) async {
    Map<String, dynamic> auth = await AuthMiddleware.signin(email, password);
    await savePref('token', auth['token']);
    await savePref('expiredAt', auth['expiredAt']);
    await getToken();
    await getUser();
  }

  Future<bool> signup(String name, String email, String password) async {
    return await AuthMiddleware.signup(name, email, password);
  }

  Future<bool> signOut() async {
    return await deletePref('token');
  }

  Future<void> getToken() async {
    try {
      token = await getPref('token');
      expiredAt = DateTime.parse(await getPref('expiredAt'));
      if (token != null) {
        isLogin = true;
      }
    } catch (e) {
      isLogin = false;
    }
  }

  Future<void> getUser() async {
    try {
      if (token == null) throw '';
      Map<String, dynamic> data = await AuthMiddleware.get(token!);
      user = UserModel.fromMap(data);
    } catch (e) {
      isLogin = false;
    }
  }

  Future<bool?> isExpired() async {
    bool? result = false;
    if (expiredAt == null) {
      result = null;
    } else if (expiredAt!.difference(DateTime.now()).inMicroseconds > 0) {
      result = true;
    }
    return result;
  }
}
