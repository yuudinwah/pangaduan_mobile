import 'package:flutter/material.dart';
import 'package:pangaduan/commons/providers/app_provider.dart';
import 'package:pangaduan/commons/utils/color.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<AppProvider>(builder: (_, appProvider, __) {
        return Center(
          child: Stack(
            children: [
              Center(
                child: Image.asset('assets/images/logo_color.png'),
              ),
              Positioned(
                bottom: 16,
                child: Container(
                  width: width,
                  height: 80,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: teal,
                  ),
                ),
              ),
              FutureBuilder(
                future: appProvider.appInit(context),
                builder: (_, __) {
                  return const SizedBox();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
