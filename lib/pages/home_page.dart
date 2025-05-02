import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_card.dart';
import '../pages/meal_search_results_page.dart';
import '../pages/meal_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<MealProvider>(context, listen: false).loadRandomMeals();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context);
    final meals = provider.randomMeals;

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search for meals...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final query = _controller.text.trim();
                  if (query.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealSearchResultsPage(query: query),
                      ),
                    );
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        // Meals Grid
        Expanded(
          child: meals.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 meals per row
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return MealCard(
                      meal: meal,
                      onAdd: () {
                        provider.addToPlanner(meal);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added ${meal.name} to planner')),
                        );
                      },
                      onFavorite: () => provider.toggleFavorite(meal),
                      isFavorite: provider.isFavorite(meal),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MealDetailPage(meal: meal),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
