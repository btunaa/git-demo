import 'dart:convert';
import 'package:app/user_model.dart';
import 'package:http/http.dart'
    as http; // http paketimiz, veri okumak icin gerekli.

class UserService {
  final String baseUrl = "https://reqres.in/api"; // api'nin url'si

  Future<UsersModel?> fetchUsers() async {
    //kullanicilari getirmek icin kullandigimiz metod
    final url = "$baseUrl/users?page=2";
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      // durum kodu 200 yani basarili ise gelen json usersmodel nesnesine donusturulur.
      return UsersModel.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  Future<UsersModelData?> fetchUser(int userId) async {
    //secilen kullaniciyi getirmek icin kullanilir
    final url = "$baseUrl/users/$userId";
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      // durum kodu 200 ise gelen json usersmodeldata nesnesine donusturulur.
      final jsonBody = jsonDecode(res.body);
      return UsersModelData.fromJson(jsonBody['data']);
    } else {
      return null;
    }
  }
}
