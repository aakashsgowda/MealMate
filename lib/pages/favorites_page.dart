import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_page.dart'; 

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context);
    final favorites = provider.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorite meals yet.'))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favorites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 meals per row
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final meal = favorites[index];
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
                    onFavorite: () {
                      provider.toggleFavorite(meal);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            provider.isFavorite(meal)
                                ? 'Added to favorites'
                                : 'Removed from favorites',
                          ),
                        ),
                      );
                    },
                    isFavorite: provider.isFavorite(meal),
                  ),
                );
              },
            ),
    );
  }
}
