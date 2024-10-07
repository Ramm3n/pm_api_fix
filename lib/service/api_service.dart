import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sistem_pendataan_kewilayahan/models/kabupaten.dart';
import 'package:sistem_pendataan_kewilayahan/models/wilayah.dart';

class ApiService {
  final String baseUrl = 'http://18.136.123.139:8088/api';

  Future<ApiResponse> fetchProvinsi() async {
    final response = await http
        .get(Uri.parse('$baseUrl/Wilayah?RegionCode=&RegionLevel=provinsi'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      return ApiResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<KabupatenResponse> fetchKabupatenByProvinsiId(int provinsiId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/Wilayah?RegionCode=$provinsiId&RegionLevel=kabupaten'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return KabupatenResponse.fromJson(data['data']);
    } else {
      throw Exception('Gagal mengambil data kabupaten dari API');
    }
  }
}
