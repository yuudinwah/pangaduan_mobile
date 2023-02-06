import 'package:flutter/material.dart';
import 'package:pangaduan/commons/providers/app_provider.dart';
import 'package:pangaduan/commons/providers/home_provider.dart';
import 'package:pangaduan/commons/utils/color.dart';
import 'package:pangaduan/resources/models/auth_model.dart';
import 'package:pangaduan/resources/models/case_model.dart';
import 'package:pangaduan/resources/models/user_model.dart';
import 'package:pangaduan/commons/extensions/datetime_extension.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AuthModel auth = Provider.of<AppProvider>(context).auth;
    UserModel user = auth.user!;
    HomeProvider home = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        centerTitle: true,
        title: Image.asset('assets/images/logo_full_color.png'),
        actions: const [
          Icon(Icons.sort),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SmartRefresher(
        controller: home.homeController,
        onRefresh: () => home.loadCases(auth.token!),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            bottom: 100,
          ),
          child: Column(
            children: [
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: greyLight,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      alignment: Alignment.centerLeft,
                      child: Text('Selamat siang ${user.name},'),
                    ),
                    Container(
                      width: width,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Ada yang ingin kamu laporkan?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: home.caseFormController,
                                minLines: 4,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: "Laporkan disini ...",
                                  hintStyle: TextStyle(
                                    color: grey.withOpacity(0.5),
                                  ),
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  counterText: "",
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                    color: greyLight,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.image_rounded,
                                      color: grey,
                                      size: 15,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 32,
                                    ),
                                    height: 32,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: teal,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'Kirim',
                                      style: TextStyle(
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
                    ),
                  ],
                ),
              ),
              Column(
                children: List.generate(home.cases.length, (index) {
                  CaseModel caseModel = home.cases[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: greyLight,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset('assets/images/user.png'),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                                width: width,
                                child: Row(
                                  children: [
                                    Text(
                                      caseModel.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: teal,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        caseModel.status,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: SizedBox(),
                                    ),
                                    Text(
                                      (caseModel.createdAt ?? DateTime.now())
                                          .toLog(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width,
                                child: Text(
                                  caseModel.detail,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                width: width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.turn_left_sharp,
                                      color: grey,
                                      size: 20,
                                    ),
                                    Container(
                                      height: 30,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${caseModel.respond} Respon',
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
