import 'package:flutter/foundation.dart';
import '../network/user_api.dart';
import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  final UserApi _userApi = UserApi();
  bool isLoading = false;
  bool isError = false;

  late String? _errorMessage;
  String get errorMessage => _errorMessage ?? "";

  late List<UserModel> _users = [];

  List<UserModel> get users => _users;

  Future<void> getAllUsers(int? users) async {
    isLoading = true;
    isError = false;
    _errorMessage = "";
    notifyListeners();
    try {
      _users = await _userApi.getUsers(users);
    } catch (e) {
      isError = true;
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addUser(String name) async {
    try {
      Map<String, dynamic> data = {
        "name": name,
        "job": "leader",
        "avatar": "https://reqres.in/img/faces/1-image.jpg"
      };

      final bool status = await _userApi.addUser(data);
      return status;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(String name) async {
    try {
      Map<String, dynamic> data = {
        "id": "814",
        "name": name,
        "job": "zion resident"
      };
      final bool status = await _userApi.updateUser(data);
      return status;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser() async {
    try {
      final bool status = await _userApi.deleteUser();
      return status;
    } catch (e) {
      return false;
    }
  }
}
