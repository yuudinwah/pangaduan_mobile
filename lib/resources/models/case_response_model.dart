class CaseResponseModel {
  String id;
  String caseID;
  String userID;
  String response;
  DateTime? createdAt;
  DateTime? updatedAt;

  CaseResponseModel(
    this.id, {
    required this.caseID,
    required this.userID,
    required this.response,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CaseResponseModel.fromMap(Map<String, dynamic> value) {
    return CaseResponseModel(
      value['id'],
      caseID: value['caseID'],
      userID: value['userID'],
      response: value['response'],
      createdAt: DateTime.tryParse(value['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(value['updatedAt'] ?? ''),
    );
  }
}
