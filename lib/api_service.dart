import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ApiService {
  final String apiUrl;

  ApiService({required this.apiUrl});

  Future<List<Meal>> fetchMeals() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List mealsData = jsonData['meals'] ?? [];
        return mealsData.map((meal) => Meal.fromJson(meal)).toList();
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
