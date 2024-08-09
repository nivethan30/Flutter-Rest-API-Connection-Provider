import '../model/user.dart';
import '../network/network.dart';

class UserApi {
  final NetworkClass _network = NetworkClass();

  Future<List<UserModel>> getUsers(int? users) async {
    String endPoint = "";
    if (users == null) {
      endPoint = "/users";
    } else {
      endPoint = "/users?delay=3";
    }

    try {
      Response response = await _network.get(endPoint: endPoint);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List<dynamic> userJson = data['data'];
        List<UserModel> users =
            userJson.map((e) => UserModel.fromMap(e)).toList();
        return users;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addUser(Map<String, dynamic> data) async {
    const String endPoint = "/users";
    try {
      Response response = await _network.post(endPoint: endPoint, data: data);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateUser(Map<String, dynamic> data) async {
    const String endPoint = "/users/2";
    try {
      Response response = await _network.put(endPoint: endPoint, data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteUser() async {
    const String endPoint = "/users/2";
    try {
      Response response = await _network.delete(endPoint: endPoint);
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
