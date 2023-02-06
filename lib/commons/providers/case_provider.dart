import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pangaduan/resources/middlewares/case_response_middleware.dart';
import 'package:pangaduan/resources/models/case_response_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CaseProvider with ChangeNotifier {
  final String id;
  CaseProvider(this.id);
  List<CaseResponseModel> responds = [];
  RefreshController caseController = RefreshController();
  bool fullLoad = true;
  Timer? timer;

  Future<void> init(String token) async {
    if (timer == null) {
      timer = Timer.periodic(
        const Duration(minutes: 15),
        (timer) async {
          await loadCaseResponse(token);
        },
      );
      await loadCaseResponse(token);
      fullLoad = false;
      notifyListeners();
    }
  }

  Future<void> loadCaseResponse(String token) async {
    try {
      List<Map<String, dynamic>> raw =
          await CaseResponseMiddleware.fetch(token, id);
      responds = raw.map((e) => CaseResponseModel.fromMap(e)).toList();
    } catch (e) {
      null;
    }
    caseController.refreshCompleted();
    notifyListeners();
  }
}
