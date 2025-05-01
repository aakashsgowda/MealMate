import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../providers/meal_provider.dart';

class MealDetailPage extends StatelessWidget {
  final Meal meal;

  const MealDetailPage({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context);
    final isFavorite = provider.isFavorite(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image section
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                meal.thumbnailUrl,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(height: 20),

            // Icon-only buttons with tooltips
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tooltip(
                  message: 'Add to Planner',
                  child: ElevatedButton(
                    onPressed: () {
                      provider.addToPlanner(meal);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added ${meal.name} to planner')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                      backgroundColor: Colors.green,
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 24),
                Tooltip(
                  message: isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                  child: ElevatedButton(
                    onPressed: () {
                      provider.toggleFavorite(meal);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFavorite
                                ? 'Removed from favorites'
                                : 'Added to favorites',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                      backgroundColor: Colors.red,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Instructions
            Text(
              'Instructions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(meal.instructions, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 30),

            // Ingredients
            if (meal.ingredients.isNotEmpty) ...[
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ...meal.ingredients.map((ing) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $ing'),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
