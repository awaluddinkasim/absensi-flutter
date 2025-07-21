import 'package:absensi/models/user.dart';

class Auth {
  final String token;
  final User user;

  Auth({required this.token, required this.user});

  Auth copyWith({String? token, User? user}) {
    return Auth(token: token ?? this.token, user: user ?? this.user);
  }
}
