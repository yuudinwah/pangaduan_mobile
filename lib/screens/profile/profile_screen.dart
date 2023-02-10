import 'package:flutter/material.dart';
import 'package:pangaduan/commons/providers/app_provider.dart';
import 'package:pangaduan/commons/providers/home_provider.dart';
import 'package:pangaduan/commons/utils/color.dart';
import 'package:pangaduan/resources/models/auth_model.dart';
import 'package:pangaduan/resources/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AppProvider app = Provider.of<AppProvider>(context);
    AuthModel auth = app.auth;
    UserModel user = auth.user!;
    HomeProvider home = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: teal,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: home.profileController,
        onRefresh: () => home.loadProfile(app),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      height: 80,
                      width: width,
                      color: teal,
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        height: 80,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: teal,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                user.name[0],
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width,
                                    child: Text(
                                      user.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                    width: width,
                                    child: Text(
                                      user.email,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      width: width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                            width: width,
                            child: const Text(
                              'Keamanan',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.password,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Password',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.pin,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Kelola Keamanan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.smartphone,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Kelola Perangkat',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      width: width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                            width: width,
                            child: const Text(
                              'Aduan',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.event,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Aduan Saya',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.map,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Respon Aduan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.print,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Laporan Aduan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      width: width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                            width: width,
                            child: const Text(
                              'Layanan',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.assistant,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Bantuan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Informasi Lain',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Kontak Kami',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.web,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tentang Kami',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Keluar Akun'),
                            content: const Text(
                              'Lanjutkan keluar akun?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text('Ya'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text('Tidak'),
                              ),
                            ],
                          ),
                        ).then((value) async {
                          if (value ?? false) {
                            bool action = await auth.signOut();
                            if (action) {
                              Future.delayed(const Duration()).then((value) {
                                Navigator.pushReplacementNamed(context, 'auth');
                              });
                            }
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        color: Colors.white,
                        width: width,
                        alignment: Alignment.center,
                        child: const Text(
                          'Keluar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      child: Text(
                        'versi 1.31.21 +27',
                        style: TextStyle(
                          color: greyLight,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
