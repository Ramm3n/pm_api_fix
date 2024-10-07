import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_pendataan_kewilayahan/utils/api_constants.dart';

part 'golongan_darah_state.dart';

class GolonganDarahCubit extends Cubit<GolonganDarahState> {
  GolonganDarahCubit() : super(GolonganDarahInitial());

  void getGolonganDarah(String token) async {
    emit(GolonganDarahLoading());
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/master/golongan-darah'),
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(GolonganDarahSuccess(data: jsonData));
    } else {
      emit(GolonganDarahError('error'));
    }
    print('data goldar $jsonData');
  }
}
