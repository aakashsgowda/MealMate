import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  /// Fetch a single random meal
  static Future<Meal?> fetchRandomMeal() async {
    final response = await http.get(Uri.parse('$baseUrl/random.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final meals = data['meals'];
      if (meals != null && meals.isNotEmpty) {
        return Meal.fromJson(meals[0]);
      }
    }
    return null;
  }

  /// Fetch multiple random meals
  static Future<List<Meal>> fetchRandomMeals(int count) async {
    List<Meal> meals = [];
    for (int i = 0; i < count; i++) {
      final meal = await fetchRandomMeal();
      if (meal != null) {
        meals.add(meal);
      }
    }
    return meals;
  }

  /// Search for meals by keyword
  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['meals'];
      if (results != null) {
        return List<Meal>.from(results.map((m) => Meal.fromJson(m)));
      }
    }
    return [];
  }
}
