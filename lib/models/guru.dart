class Guru {
  final String nama;
  final String email;
  final String alamat;
  final String nomorTelepon;

  const Guru({required this.nama, required this.email, required this.alamat, required this.nomorTelepon});

  factory Guru.fromJson(Map<String, dynamic> json) {
    return Guru(nama: json['nama'], email: json['email'], alamat: json['alamat'], nomorTelepon: json['no_telepon']);
  }
}
