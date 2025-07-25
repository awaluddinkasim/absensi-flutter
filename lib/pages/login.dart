import 'package:absensi/cubit/auth_cubit.dart';
import 'package:absensi/cubit/auth_state.dart';
import 'package:absensi/pages/home.dart';
import 'package:absensi/shared/widgets/dialog/loading.dart';
import 'package:absensi/shared/widgets/dialog/message.dart';
import 'package:absensi/shared/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nis = TextEditingController();
  final _password = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/logo.png'),
              const SizedBox(height: 16),
              const Text("SMKS H. A WASIR ALI", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 28),
              Input(
                controller: _nis,
                label: "Nomor Induk Siswa",
                icon: const Icon(Icons.person),
                hintText: "Masukkan nis",
                keyboardType: TextInputType.number,
              ),
              Input(
                controller: _password,
                label: "Password",
                icon: const Icon(Icons.lock),
                hintText: "Masukkan password",
                obscureText: !_showPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  icon: Icon(!_showPassword ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              const SizedBox(height: 24),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const LoadingDialog();
                      },
                    );
                  }
                  if (state is AuthFailed) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return MessageDialog(
                          status: 'Gagal',
                          message: state.error,
                          onOkPressed: () {
                            Navigator.pop(context);
                            FocusScope.of(context).unfocus();
                          },
                        );
                      },
                    );
                  }
                  if (state is AuthSuccess) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
                  }
                },
                child: FilledButton(
                  onPressed: () {
                    context.read<AuthCubit>().login(_nis.text, _password.text);
                  },
                  child: const Text("L O G I N"),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
