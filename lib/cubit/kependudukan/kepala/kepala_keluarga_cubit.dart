import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kepala/kepala_keluarga_state.dart';
import 'package:sistem_pendataan_kewilayahan/utils/api_constants.dart';

class KepalaKeluargaCubit extends Cubit<KepalaKeluargaState> {
  KepalaKeluargaCubit() : super(KepalaKeluargaInitial());

  Future<void> loadKepalaKeluarga(String token, String userId) async {
    emit(KepalaKeluargaLoading());
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/kependudukan/kepalakel'),
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    print("get kepkel ${jsonData}");
    if (jsonData['status'] == 200) {
      // final Map<String, dynamic> jsonData = json.decode(response.body);
      // final data = ApiResponse.fromJson(jsonData);
      emit(KepalaKeluargaLoaded(jsonData));
    } else if (jsonData['status'] == 401) {
      emit(ExpiredToken());
    } else {
      emit(KepalaKeluargaError('error'));
    }
  }
}
