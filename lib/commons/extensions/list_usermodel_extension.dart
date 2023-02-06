import 'package:pangaduan/resources/models/case_model.dart';

extension ListCaseModelExtension on List<CaseModel> {
  CaseModel? getCase(String caseID) {
    int index = indexWhere((element) => element.id == caseID);
    if (index >= 0) {
      return this[index];
    }
    return null;
  }
}
