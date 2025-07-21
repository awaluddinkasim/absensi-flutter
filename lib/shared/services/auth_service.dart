import 'package:absensi/data/auth.dart';
import 'package:absensi/models/user.dart';
import 'package:absensi/shared/dio.dart';

class AuthService {
  Future<Auth> getUser(String token) async {
    final response = await Request.get('/user', headers: {'Authorization': 'Bearer $token'});

    User user = User.fromJson(response['user']);

    return Auth(token: token, user: user);
  }

  Future<String> updatePassword(String token, String password) async {
    final response = await Request.put('/password', data: {'password': password}, headers: {'Authorization': 'Bearer $token'});

    return response['message'];
  }

  Future<Auth> login(String email, String password) async {
    final response = await Request.post('/login', data: {'email': email, 'password': password});

    String token = response['token'];
    User user = User.fromJson(response['user']);

    return Auth(token: token, user: user);
  }

  Future<bool> logout(String token) async {
    final response = await Request.post('/logout', headers: {'Authorization': 'Bearer $token'});

    return response['status'] == "success";
  }
}
