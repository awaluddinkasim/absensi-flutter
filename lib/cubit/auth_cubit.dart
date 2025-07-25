import 'package:absensi/cubit/auth_state.dart';
import 'package:absensi/models/user.dart';
import 'package:absensi/shared/constants.dart';
import 'package:absensi/shared/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthInitial()) {
    checkAuth();
  }

  User get user => (state as AuthSuccess).auth.user;

  Future<void> checkAuth() async {
    emit(AuthLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      if (token != null) {
        final result = await _authService.getUser(token);

        emit(AuthSuccess(result));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      await Constants.storage.delete(key: 'token');
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> login(String nis, String password) async {
    emit(AuthLoading());

    try {
      final auth = await _authService.login(nis, password);

      await Constants.storage.write(key: 'token', value: auth.token);

      emit(AuthSuccess(auth));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      await _authService.logout(token!);
      await Constants.storage.delete(key: 'token');

      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> updateUser(User user) async {
    final currentState = state;

    if (currentState is AuthSuccess) {
      emit(AuthSuccess(currentState.auth.copyWith(user: user)));
    }
  }
}
