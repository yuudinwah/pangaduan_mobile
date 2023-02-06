import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pangaduan/commons/providers/app_provider.dart';
import 'package:pangaduan/commons/providers/home_provider.dart';
import 'package:pangaduan/commons/utils/color.dart';
import 'package:pangaduan/screens/auth/auth_screen.dart';
import 'package:pangaduan/screens/container/container_screen.dart';
import 'package:pangaduan/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider(),
        ),
      ],
      builder: (_, __) {
        return Consumer2<AppProvider, HomeProvider>(
          builder: (_, app, home, ___) {
            return MaterialApp(
              title: 'Pangadu',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(
                    color: grey,
                  ),
                  elevation: 0.5,
                  titleTextStyle: TextStyle(
                    color: grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                primarySwatch: Colors.blue,
              ),
              home: const SplashScreen(),
              routes: {
                'home': (context) => const ContainerScreen(),
                'auth': (context) => const AuthScreen(),
              },
            );
          },
        );
      },
    );
  }
}
