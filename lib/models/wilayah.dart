class ApiResponse {
  final int status;
  final String message;
  final Data data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final int jumlahKelurahan;
  final List<Wilayah> wilayah;

  Data({
    required this.jumlahKelurahan,
    required this.wilayah,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var wilayahList = json['Wilayah'] as List;
    List<Wilayah> wilayah =
        wilayahList.map((data) => Wilayah.fromJson(data)).toList();

    return Data(
      jumlahKelurahan: json['JumlahKelurahan'],
      wilayah: wilayah,
    );
  }
}

class Wilayah {
  final String kodeProvinsi;
  final String kodeKabupaten;
  final String kodeKecamatan;
  final String kodeKelurahan;
  final String provinsi;
  final String kabupaten;
  final String kecamatan;
  final String kelurahan;

  Wilayah({
    required this.kodeProvinsi,
    required this.kodeKabupaten,
    required this.kodeKecamatan,
    required this.kodeKelurahan,
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
  });

  factory Wilayah.fromJson(Map<String, dynamic> json) {
    return Wilayah(
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
