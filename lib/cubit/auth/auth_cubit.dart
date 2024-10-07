import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_pendataan_kewilayahan/utils/api_constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void doLogin(String username, String password) async {
    emit(AuthLoading());
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/auth/login'),
      body: {'email': username, 'password': password},
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(AuthSuccess(data: jsonData));
      print('berhasil $jsonData');
    } else {
      emit(AuthFailed(isLogged: false));
      print('gagal $jsonData');
    }
    // print(jsonData);
  }
}
