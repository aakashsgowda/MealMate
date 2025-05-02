import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_page.dart';

class MealSearchResultsPage extends StatelessWidget {
  final String query;

  const MealSearchResultsPage({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Results for "$query"')),
      body: FutureBuilder<List<Meal>>(
        future: provider.searchMeals(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No meals found.'));
          }

          final meals = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: meals.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //3 meals per row
              childAspectRatio: 0.9,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final meal = meals[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailPage(meal: meal),
                    ),
                  );
                },
                child: MealCard(
                  meal: meal,
                  onAdd: () {
                    provider.addToPlanner(meal);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added ${meal.name} to planner')),
                    );
                  },
                  onFavorite: () => provider.toggleFavorite(meal),
                  isFavorite: provider.isFavorite(meal),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
