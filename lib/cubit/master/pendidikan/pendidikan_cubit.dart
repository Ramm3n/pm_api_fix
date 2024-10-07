import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_pendataan_kewilayahan/utils/api_constants.dart';

part 'pendidikan_state.dart';

class PendidikanCubit extends Cubit<PendidikanState> {
  PendidikanCubit() : super(PendidikanInitial());

  void getPendidikan(String token) async {
    emit(PendidikanLoading());
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/master/Pendidikan'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(PendidikanSuccess(data: jsonData));
    } else {
      emit(PendidikanError('error'));
    }
    print('data goldar $jsonData');
  }
}
