import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_pendataan_kewilayahan/utils/api_constants.dart';

part 'agama_state.dart';

class AgamaCubit extends Cubit<AgamaState> {
  AgamaCubit() : super(AgamaInitial());

  void getAgama(String token) async {
    emit(AgamaLoading());
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/master/agama'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(AgamaSuccess(data: jsonData));
    } else {
      emit(AgamaError('error'));
    }
    print('data goldar $jsonData');
  }
}
