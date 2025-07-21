import 'package:absensi/cubit/auth_cubit.dart';
import 'package:absensi/cubit/auth_state.dart';
import 'package:absensi/pages/login.dart';
import 'package:absensi/pages/mapel.dart';
import 'package:absensi/shared/widgets/dialog/loading.dart';
import 'package:absensi/shared/widgets/dialog/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().user;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Transform(
                transform: Matrix4.translationValues(0, -100, 0),
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("SMKS H A WASIR ALI", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    Text("Selamat Datang, ${user.nama}", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthInitial) {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                        }
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
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () => context.read<AuthCubit>().logout(),
                          child: Text("Keluar", style: TextStyle(color: Colors.red.shade300, fontSize: 16, fontWeight: FontWeight.bold)),
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    SvgPicture.asset('assets/sekolah-1.svg'),
                    Text("Aplikasi Absensi Online Berbasis QR Code"),
                    SizedBox(height: 16),
                    Material(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MataPelajaranScreen()));
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(child: Text("Buka Daftar Pelajaran", style: TextStyle(fontSize: 16, color: Colors.white))),
                              Icon(Icons.arrow_forward_ios, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
