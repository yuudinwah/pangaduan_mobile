import 'package:pangaduan/resources/models/user_model.dart';

extension ListUserModelExtension on List<UserModel> {
  UserModel? getUser(String userID) {
    int index = indexWhere((element) => element.id == userID);
    if (index >= 0) {
      return this[index];
    }
    return null;
  }
}
