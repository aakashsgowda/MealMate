import 'package:flutter_test/flutter_test.dart';
import 'package:cs442_mp6/models/meal.dart';

void main() {
  group('Meal Model', () {
    const sampleJson = {
      'idMeal': '12345',
      'strMeal': 'Pasta',
      'strMealThumb': 'http://example.com/thumb.jpg',
      'strInstructions': 'Boil and mix.',
      'strIngredient1': 'Pasta',
      'strMeasure1': '200g',
      'strIngredient2': 'Cheese',
      'strMeasure2': '50g',
    };

    test('fromJson parses correctly', () {
      final meal = Meal.fromJson(sampleJson);
      expect(meal.id, '12345');
      expect(meal.name, 'Pasta');
      expect(meal.instructions, 'Boil and mix.');
      expect(meal.ingredients.length, 2);
    });

    test('toJsonString converts to string', () {
      final meal = Meal.fromJson(sampleJson);
      final jsonStr = meal.toJsonString();
      expect(jsonStr, isA<String>());
      expect(jsonStr.contains('Pasta'), true);
    });

    test('fromJsonString parses back correctly', () {
      final meal = Meal.fromJson(sampleJson);
      final jsonStr = meal.toJsonString();
      final parsed = Meal.fromJsonString(jsonStr);
      expect(parsed.name, 'Pasta');
      expect(parsed.ingredients.length, 2);
    });

    test('Empty ingredients are filtered out', () {
      final customJson = {
        ...sampleJson,
        'strIngredient3': '',
        'strMeasure3': null,
      };
      final meal = Meal.fromJson(customJson);
      expect(meal.ingredients.length, 2);
    });

    test('Handles missing fields gracefully', () {
      final minimalJson = {'idMeal': '1', 'strMeal': 'Rice'};
      final meal = Meal.fromJson(minimalJson);
      expect(meal.instructions, '');
      expect(meal.thumbnailUrl, '');
    });
  });
}
