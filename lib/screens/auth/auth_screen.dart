import 'package:flutter/material.dart';
import 'package:pangaduan/commons/providers/app_provider.dart';
import 'package:pangaduan/commons/providers/auth_provider.dart';
import 'package:pangaduan/commons/utils/color.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      builder: (_, __) => Consumer<AuthProvider>(
        builder: (_, authProvider, __) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  teal,
                  yellow,
                ],
              ),
            ),
            child: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Tentang',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              'assets/images/logo_full_bw.png',
                              width: 360,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 16,
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: authProvider.showSignupModal,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  width: width,
                                  height: 50,
                                  constraints: const BoxConstraints(
                                    maxWidth: 360,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Daftar',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: teal,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 30,
                                width: width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Sudah punya akun? ',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: authProvider.showSigninModal,
                                      child: const Text(
                                        'Masuk',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (authProvider.authMode.isNotEmpty)
                  Container(
                    width: width,
                    height: height,
                    color: Colors.black.withOpacity(0.25),
                  ),
                // Signup
                AnimatedPositioned(
                  bottom: authProvider.authMode == 'Signup' ? 0 : -height,
                  duration: const Duration(
                    milliseconds: 250,
                  ),
                  child: GestureDetector(
                    onTap: () => authProvider.closeModal(context),
                    child: Container(
                      width: width,
                      height: height,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            height: 420,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: width,
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    'Daftar',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: teal,
                                          border: Border.all(
                                            width: 2,
                                            color: teal,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.face,
                                          color: Colors.white,
                                          size: 76,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: yellow,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Nama',
                                              style: TextStyle(
                                                color: grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: TextField(
                                                controller:
                                                    authProvider.nameController,
                                                maxLines: 1,
                                                maxLength: 90,
                                                textAlign: TextAlign.end,
                                                decoration: InputDecoration(
                                                  hintText: "Masukkan nama",
                                                  hintStyle: TextStyle(
                                                    color:
                                                        grey.withOpacity(0.5),
                                                  ),
                                                  border: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  focusedErrorBorder:
                                                      InputBorder.none,
                                                  counterText: "",
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                color: grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: TextField(
                                                controller: authProvider
                                                    .emailController,
                                                maxLines: 1,
                                                maxLength: 90,
                                                textAlign: TextAlign.end,
                                                decoration: InputDecoration(
                                                  hintText: "Masukkan email",
                                                  hintStyle: TextStyle(
                                                    color:
                                                        grey.withOpacity(0.5),
                                                  ),
                                                  border: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  focusedErrorBorder:
                                                      InputBorder.none,
                                                  counterText: "",
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Password',
                                              style: TextStyle(
                                                color: grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: TextField(
                                                controller: authProvider
                                                    .passwordController,
                                                maxLines: 1,
                                                maxLength: 90,
                                                textAlign: TextAlign.end,
                                                obscureText:
                                                    authProvider.obscurePasword,
                                                decoration: InputDecoration(
                                                  hintText: "Masukkan password",
                                                  hintStyle: TextStyle(
                                                    color:
                                                        grey.withOpacity(0.5),
                                                  ),
                                                  border: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  focusedErrorBorder:
                                                      InputBorder.none,
                                                  counterText: "",
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: authProvider
                                                  .changeObscurePassword,
                                              child: Icon(
                                                authProvider.obscurePasword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: grey.withOpacity(0.5),
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                InkWell(
                                  onTap: () async {
                                    authProvider.signup(context, appProvider);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    width: width,
                                    height: 50,
                                    constraints: const BoxConstraints(
                                      maxWidth: 360,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: teal,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Daftar',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text:
                                        'Dengan mengklik "Daftar" anda menyetujui ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: grey,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'ketentuan penggunaan',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: yellow,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' dan ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: grey,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'kebijakan privasi',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: yellow,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '.',
                                        style: TextStyle(
                                          color: grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Signin
                AnimatedPositioned(
                  bottom: authProvider.authMode == 'Signin' ? 0 : -height,
                  duration: const Duration(
                    milliseconds: 250,
                  ),
                  child: GestureDetector(
                    onTap: () => authProvider.closeModal(context),
                    child: Container(
                      width: width,
                      height: height,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Center(
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            height: 280,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: width,
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    'Masuk',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                color: grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: TextField(
                                                controller: authProvider
                                                    .emailController,
                                                maxLines: 1,
                                                maxLength: 90,
                                                textAlign: TextAlign.end,
                                                decoration: InputDecoration(
                                                  hintText: "Masukkan email",
                                                  hintStyle: TextStyle(
                                                    color:
                                                        grey.withOpacity(0.5),
                                                  ),
                                                  border: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  focusedErrorBorder:
                                                      InputBorder.none,
                                                  counterText: "",
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Password',
                                              style: TextStyle(
                                                color: grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: TextField(
                                                controller: authProvider
                                                    .passwordController,
                                                maxLines: 1,
                                                maxLength: 90,
                                                textAlign: TextAlign.end,
                                                obscureText:
                                                    authProvider.obscurePasword,
                                                decoration: InputDecoration(
                                                  hintText: "Masukkan password",
                                                  hintStyle: TextStyle(
                                                    color:
                                                        grey.withOpacity(0.5),
                                                  ),
                                                  border: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  focusedErrorBorder:
                                                      InputBorder.none,
                                                  counterText: "",
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: authProvider
                                                  .changeObscurePassword,
                                              child: Icon(
                                                authProvider.obscurePasword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: grey.withOpacity(0.5),
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                InkWell(
                                  onTap: () =>
                                      authProvider.signin(context, appProvider),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    width: width,
                                    height: 50,
                                    constraints: const BoxConstraints(
                                      maxWidth: 360,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: teal,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Masuk',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // RichText(
                                //   textAlign: TextAlign.center,
                                //   text: TextSpan(
                                //     text: 'Lupa password ? klik ',
                                //     style: TextStyle(
                                //       fontSize: 14,
                                //       color: grey,
                                //     ),
                                //     children: [
                                //       TextSpan(
                                //         text: 'disini',
                                //         style: TextStyle(
                                //           fontSize: 14,
                                //           color: yellow,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
