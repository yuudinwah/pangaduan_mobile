class CaseModel {
  String id;
  String name;
  String email;
  String title;
  String detail;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String respond;

  CaseModel(
    this.id, {
    required this.name,
    required this.email,
    required this.title,
    required this.detail,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.respond,
  });

  factory CaseModel.fromMap(Map<String, dynamic> value) {
    return CaseModel(
      value['id'],
      name: value['name'],
      email: value['email'],
      title: value['title'],
      detail: value['detail'],
      status: value['status'] ?? '',
      respond: value['respond'] ?? '',
      createdAt: DateTime.tryParse(value['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(value['updatedAt'] ?? ''),
    );
  }
}
