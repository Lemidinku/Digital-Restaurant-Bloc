import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/meal.dart';

class MealRepository {
  final String baseUrl;

  MealRepository({required this.baseUrl});

  Future<List<Meal>> fetchMeals() async {
    final response = await http.get(Uri.parse('$baseUrl/meals'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      return body.map((dynamic item) => Meal.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }
}

// meal repository test

void main() {
  String baseUrl = 'http://10.0.2.2:9000';
  MealRepository mealRepository = MealRepository(baseUrl: baseUrl);
  print(mealRepository.fetchMeals());
}
