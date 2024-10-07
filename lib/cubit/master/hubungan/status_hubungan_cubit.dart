import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_pendataan_kewilayahan/utils/api_constants.dart';

part 'status_hubungan_state.dart';

class StatusHubunganCubit extends Cubit<StatusHubunganState> {
  StatusHubunganCubit() : super(StatusHubunganInitial());

  void getStatusHubungan(String token) async {
    emit(StatusHubunganLoading());
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/master/status-hubungan'),
      headers: {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(StatusHubunganSuccess(data: jsonData));
    } else {
      emit(StatusHubunganError('error'));
    }
    print('data hubungan $jsonData');
  }
}
