import 'dart:convert';

class Meal {
  final String id;
  final String name;
  final String thumbnailUrl;
  final String instructions;
  final List<String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    required this.instructions,
    required this.ingredients,
  });

  /// Factory to create Meal from API JSON
  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty &&
          ingredient.toString() != 'null') {
        final formatted = (measure ?? '').toString().trim().isNotEmpty
            ? '$ingredient - $measure'
            : ingredient.toString();
        ingredients.add(formatted);
      }
    }

    return Meal(
      id: json['idMeal']?.toString() ?? '',
      name: json['strMeal']?.toString() ?? '',
      thumbnailUrl: json['strMealThumb']?.toString() ?? '',
      instructions: json['strInstructions']?.toString() ?? '',
      ingredients: ingredients,
    );
  }

  /// Convert to JSON string for storage
  String toJsonString() => jsonEncode({
        'id': id,
        'name': name,
        'thumbnailUrl': thumbnailUrl,
        'instructions': instructions,
        'ingredients': ingredients,
      });

  /// Convert from JSON string (used in SharedPreferences)
  static Meal fromJsonString(String str) {
    final json = jsonDecode(str);
    return Meal(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      thumbnailUrl: json['thumbnailUrl']?.toString() ?? '',
      instructions: json['instructions']?.toString() ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
    );
  }
}
