import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pangaduan/resources/middlewares/case_middleware.dart';
import 'package:pangaduan/resources/middlewares/dashboard_middleware.dart';
import 'package:pangaduan/resources/middlewares/log_middleware.dart';
import 'package:pangaduan/resources/middlewares/user_middleware.dart';
import 'package:pangaduan/resources/models/auth_model.dart';
import 'package:pangaduan/resources/models/case_model.dart';
import 'package:pangaduan/resources/models/dashboard_model.dart';
import 'package:pangaduan/resources/models/log_model.dart';
import 'package:pangaduan/resources/models/user_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeProvider with ChangeNotifier {
  Timer? timer;
  List<CaseModel> cases = [];
  List<UserModel> users = [];
  List<LogModel> logs = [];
  DashboardModel dashboard = DashboardModel(
      waiting: '', process: '', end: '', fake: '', total: '', users: '');
  RefreshController dashboardController = RefreshController();
  RefreshController homeController = RefreshController();

  TextEditingController caseFormController = TextEditingController();
  bool fullLoad = true;

  Future<void> init(String token) async {
    if (timer == null) {
      timer = Timer.periodic(
        const Duration(minutes: 15),
        (timer) async {
          await loadDashboard(token);
          await loadCases(token);
          await loadLog(token);
          await loadUsers(token);
        },
      );
      await loadDashboard(token);
      await loadCases(token);
      await loadLog(token);
      await loadUsers(token);
      fullLoad = false;
      notifyListeners();
    }
  }

  Future<void> loadCases(String token) async {
    try {
      List<Map<String, dynamic>> raw = await CaseMiddleware.fetch(token);
      cases = raw.map((e) => CaseModel.fromMap(e)).toList();
    } catch (e) {
      null;
    }
    homeController.refreshCompleted();
    notifyListeners();
  }

  Future<void> loadDashboard(String token) async {
    try {
      Map<String, dynamic> raw = await DashboardMiddleware.fetch(token);
      dashboard = DashboardModel.fromMap(raw);
    } catch (e) {
      null;
    }
    dashboardController.refreshCompleted();
    notifyListeners();
  }

  Future<void> loadLog(String token) async {
    List<Map<String, dynamic>> raw = await LogMiddleware.fetch(token);
    logs = raw.map((e) => LogModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> loadUsers(String token) async {
    List<Map<String, dynamic>> raw = await UserMiddleware.fetch(token);
    users = raw.map((e) => UserModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> sendCase(AuthModel auth) async {
    try {
      if (caseFormController.text.isEmpty) {
        throw '';
      }
      await CaseMiddleware.add(
        userID: auth.user!.id,
        name: auth.user!.name,
        email: auth.user!.email,
        title: "-",
        detail: caseFormController.text,
      );
      caseFormController.clear();
      notifyListeners();
      await loadCases(auth.token!);
    } catch (e) {
      print(e);
      null;
    }
  }
}
