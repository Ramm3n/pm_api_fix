class Kependudukan {
  String lokasiObjekID;
  String nomorKK;
  String nik;
  String nama;
  String jenisKelamin;
  String tempatLahir;
  String tanggalLahir;
  String agama;
  String pendidikan;
  String jenisPekerjaan;
  String statusPernikahan;
  String statusHubunganKeluarga;
  String kewarganegaraan;
  String namaAyah;
  String namaIbu;
  String goldar;
  String yatimPiatu;
  String usaha;

  Kependudukan({
    required this.lokasiObjekID,
    required this.nomorKK,
    required this.nik,
    required this.nama,
    required this.jenisKelamin,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.agama,
    required this.pendidikan,
    required this.jenisPekerjaan,
    required this.statusPernikahan,
    required this.statusHubunganKeluarga,
    required this.kewarganegaraan,
    required this.namaAyah,
    required this.namaIbu,
    required this.goldar,
    required this.yatimPiatu,
    required this.usaha,
  });

  factory Kependudukan.fromJson(Map<String, dynamic> map) {
    return Kependudukan(
      lokasiObjekID: map['lokasiObjectID'],
      nomorKK: map['nomorKK'],
      nik: map['nik'],
      nama: map['nama'],
      jenisKelamin: map['jenisKelamin'],
      tempatLahir: map['tempatLahir'],
      tanggalLahir: map['tanggalLahir'],
      agama: map['agama'],
      pendidikan: map['pendidikan'],
      jenisPekerjaan: map['jenisPekerjaan'],
      statusPernikahan: map['statusPernikahan'],
      statusHubunganKeluarga: map['statusHubunganKeluarga'],
      kewarganegaraan: map['kewarganegaraan'],
      namaAyah: map['namaAyah'],
      namaIbu: map['namaIbu'],
      goldar: map['goldar'],
      yatimPiatu: map['yatimPiatu'],
      usaha: map['usaha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lokasiObjeckID': lokasiObjekID,
      'nomorKK': nomorKK,
      'nik': nik,
      'nama': nama,
      'jenisKelamin': jenisKelamin,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggalLahir,
      'agama': agama,
      'pendidikan': pendidikan,
      'jenisPekerjaan': jenisPekerjaan,
      'statusPernikahan': statusPernikahan,
      'statusHubunganKeluarga': statusHubunganKeluarga,
      'kewarganegaraan': kewarganegaraan,
      'namaAyah': namaAyah,
      'namaIbu': namaIbu,
      'goldar': goldar,
      'yatimPiatu': yatimPiatu,
      'usaha': usaha,
    };
  }
}
