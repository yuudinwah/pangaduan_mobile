import 'package:flutter/material.dart';
import 'package:pangaduan/resources/models/auth_model.dart';

class AppProvider with ChangeNotifier {
  AuthModel auth = AuthModel();

  Future<void> appInit(BuildContext context) async {
    await auth.getToken();
    if (auth.isLogin) {
      await auth.getUser();
    }
    Future.delayed(const Duration(seconds: 5)).then((value) {
      if (auth.isLogin) {
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        Navigator.pushReplacementNamed(context, 'auth');
      }
    });
  }
}
