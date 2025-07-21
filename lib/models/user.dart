import 'package:absensi/models/kelas.dart';

class User {
  final String nis;
  final String nama;
  final Kelas kelas;
  final String alamat;
  final String nomorTelepon;

  User({required this.nis, required this.nama, required this.kelas, required this.alamat, required this.nomorTelepon});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nis: json['nis'],
      nama: json['nama'],
      kelas: Kelas.fromJson(json['kelas']),
      alamat: json['alamat'],
      nomorTelepon: json['nomor_telepon'],
    );
  }
}
