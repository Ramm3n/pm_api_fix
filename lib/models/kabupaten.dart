class KabupatenResponse {
  final int jumlahKabupaten;
  final List<Kabupaten> kabupaten;

  KabupatenResponse({
    required this.jumlahKabupaten,
    required this.kabupaten,
  });

  factory KabupatenResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> kabupatenData = json['Wilayah'];
    final List<Kabupaten> kabupatenList = kabupatenData
        .map((kabupaten) => Kabupaten.fromJson(kabupaten))
        .toList();

    return KabupatenResponse(
      jumlahKabupaten: json['JumlahKabupaten'],
      kabupaten: kabupatenList,
    );
  }
}

class Kabupaten {
  final String kodeProvinsi;
  final String kodeKabupaten;
  final String kodeKecamatan;
  final String kodeKelurahan;
  final String provinsi;
  final String kabupaten;
  final String kecamatan;
  final String kelurahan;

  Kabupaten({
    required this.kodeProvinsi,
    required this.kodeKabupaten,
    required this.kodeKecamatan,
    required this.kodeKelurahan,
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
  });

  factory Kabupaten.fromJson(Map<String, dynamic> json) {
    return Kabupaten(
      kodeProvinsi: json['kodeProvinsi'],
      kodeKabupaten: json['kodeKabupaten'],
      kodeKecamatan: json['kodeKecamatan'],
      kodeKelurahan: json['kodeKelurahan'],
      provinsi: json['provinsi'],
      kabupaten: json['kabupaten'],
      kecamatan: json['kecamatan'],
      kelurahan: json['kelurahan'],
    );
  }
}
