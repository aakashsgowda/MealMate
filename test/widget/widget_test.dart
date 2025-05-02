import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cs442_mp6/widgets/meal_card.dart';
import 'package:cs442_mp6/models/meal.dart';

void main() {
  final testMeal = Meal(
    id: '1',
    name: 'Test Meal',
    thumbnailUrl: 'https://via.placeholder.com/150',
    instructions: 'Test instructions',
    ingredients: ['Ingredient 1', 'Ingredient 2'],
  );

  testWidgets('Displays meal name and image', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MealCard(
        meal: testMeal,
        onAdd: () {},
        onFavorite: () {},
        isFavorite: false,
      ),
    ));

    expect(find.text('Test Meal'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Calls onAdd when add icon is tapped', (WidgetTester tester) async {
    bool addCalled = false;
    await tester.pumpWidget(MaterialApp(
      home: MealCard(
        meal: testMeal,
        onAdd: () => addCalled = true,
        onFavorite: () {},
        isFavorite: false,
      ),
    ));

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pump(); // allow UI update
    expect(addCalled, isTrue);
  });

  testWidgets('Calls onFavorite when favorite icon is tapped', (WidgetTester tester) async {
    bool favCalled = false;
    await tester.pumpWidget(MaterialApp(
      home: MealCard(
        meal: testMeal,
        onAdd: () {},
        onFavorite: () => favCalled = true,
        isFavorite: false,
      ),
    ));

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(favCalled, isTrue);
  });

  testWidgets('Displays filled heart if isFavorite is true', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MealCard(
        meal: testMeal,
        onAdd: () {},
        onFavorite: () {},
        isFavorite: true,
      ),
    ));

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('Displays border heart if isFavorite is false', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MealCard(
        meal: testMeal,
        onAdd: () {},
        onFavorite: () {},
        isFavorite: false,
      ),
    ));

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
