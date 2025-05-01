import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import 'meal_detail_page.dart'; // ⬅️ Import the detail page

class PlannerPage extends StatelessWidget {
  const PlannerPage({Key? key}) : super(key: key);

  static const weekDays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context);

    final sortedPlanner = weekDays
        .where((day) => provider.planner.containsKey(day))
        .map((day) => MapEntry(day, provider.planner[day]!))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Weekly Planner')),
      body: sortedPlanner.isEmpty
          ? const Center(child: Text('No meals planned yet.'))
          : ListView(
              children: sortedPlanner.map((entry) {
                final day = entry.key;
                final meal = entry.value;
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      meal.thumbnailUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image),
                    ),
                  ),
                  title: Text(
                    day,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(meal.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: () {
                      provider.removeFromPlanner(day);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Removed meal for $day')),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealDetailPage(meal: meal),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
    );
  }
}
