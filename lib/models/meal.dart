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

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty &&
          ingredient != 'null') {
        final formatted = (measure ?? '').toString().trim().isNotEmpty
            ? '$ingredient - $measure'
            : ingredient;
        ingredients.add(formatted);
      }
    }

    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnailUrl: json['strMealThumb'],
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
    );
  }

  String toJsonString() => jsonEncode({
        'id': id,
        'name': name,
        'thumbnailUrl': thumbnailUrl,
        'instructions': instructions,
        'ingredients': ingredients,
      });

  static Meal fromJsonString(String str) {
    final json = jsonDecode(str);
    return Meal(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      instructions: json['instructions'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
    );
  }
}
