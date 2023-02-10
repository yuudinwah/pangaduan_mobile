import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pangaduan/commons/providers/app_provider.dart';
import 'package:pangaduan/commons/providers/home_provider.dart';
import 'package:pangaduan/commons/utils/color.dart';
import 'package:pangaduan/screens/auth/auth_screen.dart';
import 'package:pangaduan/screens/case/case_screen.dart';
import 'package:pangaduan/screens/container/container_screen.dart';
import 'package:pangaduan/screens/home/home_screen.dart';
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
                    fontSize: 16,
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
              onGenerateRoute: (settings) {
                Widget page;
                Uri uri = Uri.parse(settings.name ?? '');
                switch (uri.pathSegments.first) {
                  case 'case':
                    if (uri.pathSegments.length > 1) {
                      page = CaseScreen(uri.pathSegments[1]);
                    } else {
                      page = const HomeScreen();
                    }
                    break;
                  default:
                    page = const ContainerScreen();
                }
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (_, a1, a2) {
                    return page;
                  },
                  transitionDuration: const Duration(seconds: 0),
                );
              },
            );
          },
        );
      },
    );
  }
}
