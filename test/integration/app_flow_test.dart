import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cs442_mp6/providers/meal_provider.dart';
import 'package:cs442_mp6/widgets/bottom_nav.dart';

void main() {
  testWidgets('MealMate flow: load app and navigate tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => MealProvider(),
        child: const MaterialApp(home: BottomNavScaffold()),
      ),
    );

    await tester.pumpAndSettle();

    // Tap on Favorites
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();
    expect(find.textContaining('No favorite'), findsOneWidget);

    // Tap on Planner
    await tester.tap(find.byIcon(Icons.calendar_today));
    await tester.pumpAndSettle();
    expect(find.textContaining('No meals'), findsOneWidget);

    // Tap on Groceries
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();
    expect(find.textContaining('No ingredients'), findsOneWidget);
  });
}
