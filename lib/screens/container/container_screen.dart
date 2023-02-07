import 'package:flutter/material.dart';
import 'package:pangaduan/commons/providers/app_provider.dart';
import 'package:pangaduan/commons/providers/home_provider.dart';
import 'package:pangaduan/resources/models/auth_model.dart';
import 'package:pangaduan/resources/models/user_model.dart';
import 'package:pangaduan/screens/dashboard/dashboard_screen.dart';
import 'package:pangaduan/screens/home/home_screen.dart';
import 'package:pangaduan/screens/log/log_screen.dart';
import 'package:pangaduan/screens/profile/profile_screen.dart';
import 'package:pangaduan/commons/utils/color.dart';
import 'package:provider/provider.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({super.key});

  @override
  State<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AuthModel auth = Provider.of<AppProvider>(context).auth;
    HomeProvider home = Provider.of<HomeProvider>(context);
    if (home.timer == null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => home.init(auth.token!));
    }
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: [
                if (home.fullLoad)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (!home.fullLoad)
                  SizedBox(
                    height: height,
                    width: width,
                    child: const TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        DashboardScreen(),
                        HomeScreen(),
                        LogScreen(),
                        ProfileScreen(),
                      ],
                    ),
                  ),
                if (!home.fullLoad)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 100,
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ),
                if (!home.fullLoad)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    left: 8,
                    child: Container(
                      height: 60,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 0),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: TabBar(
                        labelColor: teal,
                        unselectedLabelColor: grey,
                        indicatorColor: Colors.transparent,
                        tabs: const [
                          Tab(
                            child: Icon(
                              Icons.widgets_rounded,
                            ),
                          ),
                          Tab(
                            child: Icon(
                              Icons.home_rounded,
                            ),
                          ),
                          Tab(
                            child: Icon(
                              Icons.notifications_none_rounded,
                            ),
                          ),
                          Tab(
                            child: Icon(
                              Icons.face,
                            ),
                          ),
                        ],
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
