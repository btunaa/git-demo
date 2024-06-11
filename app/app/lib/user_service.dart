import 'dart:convert';
import 'package:app/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = "https://reqres.in/api";

  Future<UsersModel?> fetchUsers() async {
    final url = "$baseUrl/users?page=2";
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return UsersModel.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  Future<UsersModelData?> fetchUser(int userId) async {
    final url = "$baseUrl/users/$userId";
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final jsonBody = jsonDecode(res.body);
      return UsersModelData.fromJson(jsonBody['data']);
    } else {
      return null;
    }
  }
}
