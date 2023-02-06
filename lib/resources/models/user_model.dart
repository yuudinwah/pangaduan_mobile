class UserModel {
  String id;
  String name;
  String email;
  List<String> roles;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
  });

  factory UserModel.fromMap(Map<String, dynamic> value) {
    return UserModel(
      id: value['id'],
      name: value['name'],
      email: value['email'],
      roles: List<String>.from(value['roles'] ?? []),
    );
  }
}
