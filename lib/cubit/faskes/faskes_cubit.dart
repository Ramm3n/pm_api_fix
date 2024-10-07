import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_pendataan_kewilayahan/utils/api_constants.dart';

part 'faskes_state.dart';

class FaskesCubit extends Cubit<FaskesState> {
  FaskesCubit() : super(FaskesInitial());

  void getFaskes(String token, String userId) async {
    emit(FaskesLoading());
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/survey/faskes?created_by=$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 200) {
      emit(FaskesSuccess(data: jsonData));
      //   print('berhasil $jsonData');
    }
    // debugPrint("data $jsonData");
  }
}
