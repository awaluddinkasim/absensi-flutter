import 'package:absensi/shared/constants.dart';
import 'package:absensi/shared/dio.dart';
import 'package:flutter/material.dart';

class MataPelajaranScreen extends StatefulWidget {
  const MataPelajaranScreen({super.key});

  @override
  State<MataPelajaranScreen> createState() => _MataPelajaranScreenState();
}

class _MataPelajaranScreenState extends State<MataPelajaranScreen> {
  @override
  void initState() {
    super.initState();
    _fetchMataPelajaran();
  }

  Future<void> _fetchMataPelajaran() async {
    final token = await Constants.storage.read(key: 'token');

    final response = await Request.get('/jadwal', headers: {'Authorization': 'Bearer $token'});

    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text("Mata Pelajaran", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))],
            ),
          ),
        ),
      ),
    );
  }
}
