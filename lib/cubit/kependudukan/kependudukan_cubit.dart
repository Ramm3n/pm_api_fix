import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sistem_pendataan_kewilayahan/models/kabupaten.dart';
import 'package:sistem_pendataan_kewilayahan/models/wilayah.dart';
import 'package:sistem_pendataan_kewilayahan/service/api_service.dart';
import 'package:sistem_pendataan_kewilayahan/utils/api_constants.dart';

part 'kependudukan_state.dart';

class KependudukanCubit extends Cubit<KependudukanState> {
  KependudukanCubit() : super(KependudukanInitial());

  void postKepalaKeluarga(
    String token,
    String nomorKK,
    String namaKK,
    String alamat,
    String rt,
    String rw,
    String kel,
    String kec,
    String kota,
    String prov,
    String lokasiObjectId,
  ) async {
    emit(KependudukanLoading());
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/kepalakel'),
      body: {
        'nomor_kk': nomorKK,
        'nama_kk': namaKK,
        'alamat': alamat,
        'rt': rt,
        'rw': rw,
        'desa_kelurahan': kel,
        'kecamatan': kec,
        'kota': kota,
        'provinsi': prov,
        'id_lokasi_objek': lokasiObjectId,
      },
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(PostPendudukResponse(isResponse: true));
    } else if (jsonData['response'] != null) {
      emit(PostPendudukResponse(isResponse: true));
    } else if (jsonData['status'] == 401) {
      emit(ExpiredTokenInput());
    } else {
      emit(PostPendudukResponse(isResponse: false));
    }
    print(response.body);
  }

  void editKepalaKeluarga(
    String token,
    String idKepalaKeluarga,
    String nomorKK,
    String namaKK,
    String alamat,
    String rt,
    String rw,
    String kel,
    String kec,
    String kota,
    String prov,
    String lokasiObjectId,
    String idPic,
  ) async {
    final response = await http.put(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/kepalakel/$idKepalaKeluarga'),
      body: {
        'nomor_kk': nomorKK,
        'nama_kk': namaKK,
        'alamat': alamat,
        'rt': rt,
        'rw': rw,
        'desa_kelurahan': kel,
        'kecamatan': kec,
        'kota': kota,
        'provinsi': prov,
        'lokasi_objek_id': lokasiObjectId,
        'pic': lokasiObjectId,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(PostPendudukResponse(isResponse: true));
    } else if (jsonData['status'] == 404) {
      emit(PostPendudukResponse(isResponse: true));
    } else if (jsonData['response'] != null) {
      emit(PostPendudukResponse(isResponse: true));
    } else if (jsonData['status'] == 401) {
      emit(ExpiredTokenInput());
    } else {
      emit(PostPendudukResponse(isResponse: false));
    }
    print('edit kk $jsonData');
  }

  void deleteKepalaKeluarga(String token, String idKepalaKeluarga) async {
    final response = await http.delete(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/kepalakel/$idKepalaKeluarga'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print('delete kepala  $jsonData');
  }

  void postAnggotaKeluarga(
    String token,
    String nomorKK,
    String nik,
    String nama,
    String jenisKelamin,
    String tempatLahir,
    String tanggalLahir,
    String agama,
    String pendidikan,
    String jenisPekerjaan,
    String statusPernikahan,
    String statusHubunganKeluarga,
    String kewarganegaraan,
    String namaAyah,
    String namaIbu,
    String goldar,
    String yatimPiatu,
    String usaha,
  ) async {
    // DateTime parsedDate = DateFormat('yyyy-MM-dd').parse('2023-10-04');
    String dateString = "2023-10-04"; // Replace this with your date string
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(dateString);
    // String parsedStr = DateFormat('yyyy-MM-dd').format(parsedDate);

    emit(KependudukanLoading());
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/anggotakel'),
      body: {
        'nomor_kk': nomorKK.toString(),
        'nik': nik,
        'nama': nama,
        'jenis_kelamin_id': jenisKelamin,
        'tempat_lahir': tempatLahir,
        'tanggal_lahir': tanggalLahir,
        'agama_id': agama,
        'pendidikan_id': pendidikan,
        'pekerjaan_id': jenisPekerjaan,
        'status_pernikahan_id': statusPernikahan,
        'status_hubungan_id': statusHubunganKeluarga,
        'kewarganegaraan_id': kewarganegaraan,
        'nama_ayah': namaAyah,
        'nama_ibu': namaIbu,
        'golongan_darah_id': goldar,
        'yatim_piatu': yatimPiatu,
        'memiliki_usaha': usaha,
      },
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print(jsonData);
    if (jsonData['status'] == 200) {
      emit(DataAnggotaFailure(isResponse: true, msg: jsonData['message']));
    } else if (jsonData['response'] != null) {
      emit(DataAnggotaFailure(isResponse: true, msg: jsonData['message']));
    } else if (jsonData['message'] == 'Anggota keluarga successfully created') {
      emit(DataAnggotaFailure(isResponse: true, msg: jsonData['message']));
    } else if (jsonData['status'] == 401) {
      emit(ExpiredTokenInput());
    } else {
      emit(DataAnggotaFailure(isResponse: false, msg: jsonData['message']));
    }

    // emit(KependudukanSuccess(data: response));
    // if (response.statusCode == 201) {
    //   // emit([...state, PostModel.fromJson(jsonDecode(response.body))]);
    //   print(response);
    // } else {
    //   throw Exception('Failed to create post');
    // }/api/kependudukan/anggotakel/update/4
  }

  void editAnggotaKeluarga(
    String token,
    String idAnggota,
    String nomorKK,
    String nik,
    String nama,
    String jenisKelamin,
    String tempatLahir,
    String tanggalLahir,
    String agama,
    String pendidikan,
    String jenisPekerjaan,
    String statusPernikahan,
    String statusHubunganKeluarga,
    String kewarganegaraan,
    String namaAyah,
    String namaIbu,
    String goldar,
    String yatimPiatu,
    String usaha,
    String idPic,
  ) async {
    // DateTime parsedDate = DateFormat('yyyy-MM-dd').parse('2023-10-04');
    String dateString = "2023-10-04"; // Replace this with your date string
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(dateString);
    // String parsedStr = DateFormat('yyyy-MM-dd').format(parsedDate);

    emit(KependudukanLoading());
    final response = await http.put(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/anggotakel/$idAnggota'),
      body: {
        'nomor_kk': nomorKK.toString(),
        'nik': nik,
        'nama': nama,
        'jenis_kelamin_id': jenisKelamin,
        'tempat_lahir': tempatLahir,
        'tanggal_lahir': tanggalLahir,
        'agama_id': agama,
        'pendidikan_id': pendidikan,
        'pekerjaan_id': jenisPekerjaan,
        'status_pernikahan_id': statusPernikahan,
        'status_hubungan_id': statusHubunganKeluarga,
        'kewarganegaraan_id': kewarganegaraan,
        'nama_ayah': namaAyah,
        'nama_ibu': namaIbu,
        'golongan_darah_id': goldar,
        'yatim_piatu': yatimPiatu,
        'memiliki_usaha': usaha,
        'pic': idPic,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print(jsonData);
    if (jsonData['status'] == 200) {
      emit(DataAnggotaFailure(isResponse: true, msg: jsonData['message']));
    } else if (jsonData['response'] != null) {
      emit(DataAnggotaFailure(isResponse: true, msg: jsonData['message']));
    } else if (jsonData['message'] == 'Anggota keluarga successfully created') {
      emit(DataAnggotaFailure(isResponse: true, msg: jsonData['message']));
    } else if (jsonData['status'] == 401) {
      emit(ExpiredTokenInput());
    } else {
      emit(DataAnggotaFailure(isResponse: false, msg: jsonData['message']));
    }

    // emit(KependudukanSuccess(data: response));
    // if (response.statusCode == 201) {
    //   // emit([...state, PostModel.fromJson(jsonDecode(response.body))]);
    // print(response);
    // } else {
    //   throw Exception('Failed to create post');
    // }
  }

  void deleteAnggotaKeluarga(String token, String idAnggota) async {
    final response = await http.delete(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/anggotakel/$idAnggota'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      ResponseDeleteData(isResponse: true, msg: jsonData['message']);
    }
    print('delete anggota  $jsonData');
  }

  void postDataKeluarga(
    String token,
    String nomorKK,
  ) async {
    emit(KependudukanLoading());
    final response = await http.get(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/anggotakel?nomor_kk=$nomorKK'),
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print('anggota $jsonData');
    if (jsonData['status'] == 200) {
      emit(KependudukanSuccess(data: jsonData));
    } else if (jsonData['status'] == 401) {
      emit(ExpiredTokenInput());
    } else {
      emit(DataFailure(data: jsonData));
    }
  }

  void postPSKS(
    String token,
    String Nik,
    String Jenispsks,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/psks/add'),
      body: {
        'nik': Nik,
        'Jenispsks': Jenispsks,
      },
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    print("psks ${response.body}");
  }

  void postPPKS(
    String token,
    String Nik,
    String Jenisppks,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/ppks/add'),
      body: {
        'nik': Nik,
        'Jenisppks': Jenisppks,
      },
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    print("ppks ${response.body}");
  }

  void postBansos(String token, String Nik, String BansosJenis) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/jenisbansos/add'),
      body: {'nik': Nik, 'BansosJenis': BansosJenis},
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    print("bansos add ${response.body}");
  }
}

class LokasiCubit extends Cubit<LokasiState> {
  LokasiCubit() : super(LokasiInitial());
  void postLokasiObject(
    String token,
    String IdJenisObjek,
    String IdentitasObjek,
    String alamat,
    String rt,
    String rw,
    String DesaKelurahan,
    String Kecamatan,
    String KotaKab,
    String Provinsi,
    String Latitude,
    String Longitude,
  ) async {
    emit(LokasiLoading());
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/lokasiobjek/add'),
      body: {
        'IDJenisObjek': IdJenisObjek,
        'IdentitasObjek': IdentitasObjek,
        'NamaObjek': '',
        'Alamat': alamat,
        'Rt': rt,
        'Rw': rw,
        'DesaKelurahan': DesaKelurahan,
        'Kecamatan': Kecamatan,
        'KotaKab': KotaKab,
        'Provinsi': Provinsi,
        'Latitude': Latitude,
        'Longitude': Longitude,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 201) {
      emit(LokasiObjekSuccess(data: jsonData, isResponse: true));
      // emit(LokasiObjekBerhasil());
    } else if (jsonData['status'] == 401) {
      emit(ExpiredLokasiInput());
    } else {
      emit(LokasiObjekSuccess(data: jsonData, isResponse: false));
      // emit(DataFailure(data: jsonData));
    }
    print('lokasi ${response.body}');
  }

  void getLokasiObject(
    String token,
    String idLokasi,
  ) async {
    final response = await http.post(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/lokasiobjek/search/$idLokasi'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    // print('lokasi obje ${jsonData}');
    if (jsonData['status'] == 200) {
      emit(GetLokasiSuccess(data: jsonData));
      // print('berhasil ${jsonData['data']}');
      // emit(LokasiObjekBerhasil());
    } else {
      emit(GetLokasiFailure(data: jsonData));
      // emit(DataFailure(data: jsonData));
    }
  }

  void editLokasiObject(
    String token,
    String idLokasi,
    String idJenisObjek,
    String identitasObjek,
    String alamat,
    String rt,
    String rw,
    String desaKelurahan,
    String kecamatan,
    String kotaKab,
    String provinsi,
    String latitude,
    String longitude,
  ) async {
    emit(LokasiLoading());
    final response = await http.post(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/lokasiobjek/update/$idLokasi'),
      body: {
        'IDJenisObjek': idJenisObjek,
        'IdentitasObjek': identitasObjek,
        'NamaObjek': '',
        'Alamat': alamat,
        'Rt': rt,
        'Rw': rw,
        'DesaKelurahan': desaKelurahan,
        'Kecamatan': kecamatan,
        'KotaKab': kotaKab,
        'Provinsi': provinsi,
        'Latitude': latitude,
        'Longitude': longitude,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(EditLokasiSuccess(data: jsonData));
      // emit(LokasiObjekBerhasil());
    } else {
      emit(EditLokasiFailure(data: jsonData));
      // emit(DataFailure(data: jsonData));
    }
    print('lokasi ${response.body}');
  }
}

class PsksCubit extends Cubit<PsksState> {
  PsksCubit() : super(PsksInitial());

  void getPSKS(
    String token,
    String Nik,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/datapsks'),
      body: {
        'nik': Nik,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    // print('psks $jsonData');
    if (jsonData['status'] == 200) {
      emit(DataPsksSuccess(data: jsonData));
    } else {
      emit(DataPsksFailure(data: jsonData));
    }
  }

  void deletePSKS(
    String token,
    // String Nik,
    String id,
    // String jenis,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/psks/delete/$id'),
      // body: {
      //   'nik': Nik,
      //   'Jenisppks': jenis,
      // },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print('ppks $jsonData');
    if (jsonData['status'] == 200) {
      emit(DeletePsksSuccess(data: jsonData));
    } else {
      emit(DeletePsksFailure(data: jsonData));
    }
  }

  void editPSKS(
    String token,
    String Nik,
    String id,
    String jenis,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/psks/update/$id'),
      body: {
        'nik': Nik,
        'Jenisppks': jenis,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print('ppks $jsonData');
    if (jsonData['status'] == 200) {
      emit(EditPsksSuccess(data: jsonData));
    } else {
      emit(EditPsksFailure(data: jsonData));
    }
  }
}

class PpksCubit extends Cubit<PpksState> {
  PpksCubit() : super(PpksInitial());

  void getPPKS(
    String token,
    String Nik,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/datappks'),
      body: {
        'nik': Nik,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    // print('ppks $jsonData');
    if (jsonData['status'] == 200) {
      emit(DataPpksSuccess(data: jsonData));
    } else {
      emit(DataPpksFailure(data: jsonData));
    }
  }

  void deletePPKS(
    String token,
    String id,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/ppks/delete/$id'),
      // body: {
      //   'nik': Nik,
      //   'Jenisppks': jenis,
      // },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print('ppks $jsonData');
    if (jsonData['status'] == 200) {
      emit(DeletePpksSuccess(data: jsonData));
    } else {
      emit(DeletePpksFailure(data: jsonData));
    }
  }

  void editPPKS(
    String token,
    String Nik,
    String id,
    String jenis,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/ppks/update/$id'),
      body: {
        'nik': Nik,
        'Jenisppks': jenis,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print('ppks $jsonData');
    if (jsonData['status'] == 200) {
      emit(EditPpksSuccess(data: jsonData));
    } else {
      emit(EditPpksFailure(data: jsonData));
    }
  }
}

class BansosCubit extends Cubit<BansosState> {
  BansosCubit() : super(BansosInitial());

  void getBansos(
    String token,
    String Nik,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/databansos'),
      body: {
        'nik': Nik,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print('bansos $jsonData');
    if (jsonData['status'] == 200) {
      emit(DataBansosSuccess(data: jsonData));
    } else {
      emit(DataBansosFailure(data: jsonData));
    }
  }

  void editBansos(
    String token,
    String Nik,
    String id,
    String jenis,
  ) async {
    final response = await http.post(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/jenisbansos/update/$id'),
      body: {
        'nik': Nik,
        'Jenisppks': jenis,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print('ppks $jsonData');
    if (jsonData['status'] == 200) {
      // emit(EditBansosSuccess(data: jsonData));
    } else {
      // emit(EditBansosFailure(data: jsonData));
    }
  }

  void deleteBansos(
    String token,
    int id,
  ) async {
    final response = await http.post(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/jenisbansos/delete/$id'),
      // body: {
      //   'nik': Nik,
      //   'Jenisppks': jenis,
      // },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print('bansos terdelete $jsonData');
    if (jsonData['status'] == 200) {
      emit(DeleteBansosSuccess(data: jsonData));
    } else {
      emit(DeleteBansosFailure(data: jsonData));
    }
  }
}

class ProvinsiCubit extends Cubit<ProvinsiState> {
  final ApiService apiService = ApiService();
  ProvinsiCubit() : super(ProvinsiInitial());

  void fetchProvinsi(String token) async {
    emit(ProvinsiLoading());
    final response = await http.post(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/wilayah?RegionCode=&RegionLevel=provinsi'),
      // body: {'nik': Nik, 'BansosJenis': BansosJenis},
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print("provinsi ${jsonData}");
    if (jsonData['status'] == 200) {
      // final Map<String, dynamic> jsonData = json.decode(response.body);
      // final data = ApiResponse.fromJson(jsonData);
      emit(ProvinsiLoaded(jsonData));
      // KabupatenCubit().fetchKabupatenByProvinsiId('');
    } else {
      emit(ProvinsiError('error'));
    }
  }
}

class KabupatenCubit extends Cubit<KabupatenState> {
  final ApiService apiService = ApiService();
  KabupatenCubit() : super(KabupatenInitial());

  void fetchKabupatenByProvinsiId(String provinsiId, String token) async {
    // emit(KabupatenLoading());
    final response = await http.post(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/wilayah?RegionCode=$provinsiId&RegionLevel=kabupaten'),
      // body: {'nik': Nik, 'BansosJenis': BansosJenis},
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print("kab ${jsonData}");
    if (jsonData['status'] == 200) {
      emit(KabupatenLoaded(jsonData));
      // print('kab ${jsonData['Status']}');
      // KecamatanCubit().fetchKecamatanByKabupatenId('');
    } else {
      emit(KabupatenError('error'));
    }
  }
}

class KecamatanCubit extends Cubit<KecamatanState> {
  final ApiService apiService = ApiService();
  KecamatanCubit() : super(KecamatanInitial());

  void fetchKecamatanByKabupatenId(String kabupatenId, String token) async {
    final response = await http.post(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/wilayah?RegionCode=$kabupatenId&RegionLevel=kecamatan'),
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(KecamatanLoaded(jsonData));
      // KelurahanCubit().fetchKelurahanByKecamatanId("");
    } else {
      emit(KecamatanError('error'));
    }
  }
}

class KelurahanCubit extends Cubit<KelurahanState> {
  final ApiService apiService = ApiService();
  KelurahanCubit() : super(KelurahanInitial());

  void fetchKelurahanByKecamatanId(String kecamatanId, String token) async {
    final response = await http.post(
      Uri.parse(
          '${ApiConstants.baseUrl}/api/kependudukan/wilayah?RegionCode=$kecamatanId&RegionLevel=kelurahan'),
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(KelurahanLoaded(jsonData));
      // print('kel ${jsonData['Status']}');
    } else {
      emit(KelurahanError('error'));
    }
  }
}
