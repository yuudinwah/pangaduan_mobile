class LogModel {
  String id;
  String userID;
  String action;
  String detail;
  DateTime? createdAt;

  LogModel(
    this.id, {
    required this.userID,
    required this.action,
    required this.detail,
    required this.createdAt,
  });

  factory LogModel.fromMap(Map<String, dynamic> value) {
    return LogModel(
      value['id'],
      userID: value['userID'],
      action: value['action'],
      detail: value['detail'],
      createdAt: DateTime.tryParse(value['createdAt']??''),
    );
  }
}
