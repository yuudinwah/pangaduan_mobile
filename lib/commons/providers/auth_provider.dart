import 'package:flutter/material.dart';
import 'package:pangaduan/commons/providers/app_provider.dart';

class AuthProvider with ChangeNotifier {
  String authMode = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePasword = true;

  void showSigninModal() {
    authMode = 'Signin';
    notifyListeners();
  }

  void showSignupModal() {
    authMode = 'Signup';
    notifyListeners();
  }

  void closeModal(BuildContext context) {
    authMode = '';
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    obscurePasword = true;
    FocusScope.of(context).requestFocus(FocusNode());
    notifyListeners();
  }

  void changeObscurePassword() {
    obscurePasword = !obscurePasword;
    notifyListeners();
  }

  String? validate() {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      return 'Mohon masukkan email yang valid';
    } else if (passwordController.text.length < 8) {
      return 'Password tidak boleh kurang dari 8 huruf';
    }
    return null;
  }

  Future<void> signup(BuildContext context, AppProvider appProvider) async {
    try {
      String? errorForm = validate();
      if (errorForm == null) {
        bool register = await appProvider.auth.signup(
            nameController.text, emailController.text, passwordController.text);
        if (register) {
          Future.delayed(const Duration()).then((_) => closeModal(context));
          showSigninModal();
          Future.delayed(const Duration()).then((_) => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Berhasil'),
                  content: const Text(
                    'Silahkan login menggunakan akun yang terdaftar',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Tutup'),
                    ),
                  ],
                ),
              ));
        }
      } else {
        throw errorForm;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Gagal'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> signin(BuildContext context, AppProvider appProvider) async {
    try {
      String? errorForm = validate();
      if (errorForm == null) {
        await appProvider.auth
            .signin(emailController.text, passwordController.text);
        Future.delayed(const Duration()).then((_) => closeModal(context));
        Future.delayed(const Duration())
            .then((_) => Navigator.pushReplacementNamed(context, 'home'));
      } else {
        throw errorForm;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Gagal'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
    }
  }
}
