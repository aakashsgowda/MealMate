import 'package:flutter/material.dart';
import '../models/meal.dart';

class PlannerTile extends StatelessWidget {
  final String day;
  final Meal? meal;

  PlannerTile({required this.day, this.meal});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(day),
      subtitle: meal != null ? Text(meal!.name) : Text('No meal planned'),
    );
  }
}