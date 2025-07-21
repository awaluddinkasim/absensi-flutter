import 'package:absensi/models/guru.dart';

class Kelas {
  final String uuid;
  final String nama;
  final Guru wali;

  const Kelas({required this.uuid, required this.nama, required this.wali});

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(uuid: json['uuid'], nama: json['nama'], wali: Guru.fromJson(json['wali_kelas']));
  }
}
