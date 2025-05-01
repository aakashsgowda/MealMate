import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal.dart';
import '../services/meal_api_service.dart';

class MealProvider with ChangeNotifier {
  List<Meal> _randomMeals = [];
  List<Meal> _favorites = [];
  Map<String, Meal> _planner = {};
  List<String> _groceries = [];

  List<Meal> get randomMeals => _randomMeals;
  List<Meal> get favorites => _favorites;
  Map<String, Meal> get planner => _planner;
  List<String> get groceries => _groceries;

  /// Fetch 6 random meals for the Home screen
  Future<void> loadRandomMeals() async {
    _randomMeals = await MealApiService.fetchRandomMeals(6);
    notifyListeners();
  }

  /// Search meals for search results page
  Future<List<Meal>> searchMeals(String query) async {
    return await MealApiService.searchMeals(query);
  }

  /// Add to planner without day (auto-inserts in order or replace logic can be added)
  void addToPlanner(Meal meal) {
    // Add to next empty day, or just overwrite the same meal
    final days = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];

    for (String day in days) {
      if (!_planner.containsKey(day)) {
        _planner[day] = meal;
        _addIngredientsToGroceries(meal);
        _saveData();
        notifyListeners();
        return;
      }
    }

    // Optional: if planner is full, overwrite last
    _planner['Sunday'] = meal;
    _addIngredientsToGroceries(meal);
    _saveData();
    notifyListeners();
  }

  void removeFromPlanner(String day) {
    if (_planner.containsKey(day)) {
      final removedMeal = _planner.remove(day);
      if (removedMeal != null) {
        _removeIngredientsFromGroceries(removedMeal);
      }
      _saveData();
      notifyListeners();
    }
  }

  void toggleFavorite(Meal meal) {
    if (_favorites.any((m) => m.id == meal.id)) {
      _favorites.removeWhere((m) => m.id == meal.id);
    } else {
      _favorites.add(meal);
    }
    _saveData();
    notifyListeners();
  }

  bool isFavorite(Meal meal) {
    return _favorites.any((m) => m.id == meal.id);
  }

  void _addIngredientsToGroceries(Meal meal) {
    for (String item in meal.ingredients) {
      if (!_groceries.contains(item)) {
        _groceries.add(item);
      }
    }
  }

  void _removeIngredientsFromGroceries(Meal meal) {
    for (String item in meal.ingredients) {
      _groceries.remove(item);
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final plannerJson = _planner.map((k, v) => MapEntry(k, v.toJsonString()));
    await prefs.setString('planner', jsonEncode(plannerJson));
    await prefs.setStringList('favorites', _favorites.map((m) => m.toJsonString()).toList());
    await prefs.setStringList('groceries', _groceries);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final planStr = prefs.getString('planner');
    if (planStr != null) {
      final Map<String, dynamic> decoded = jsonDecode(planStr);
      _planner = decoded.map((k, v) => MapEntry(k, Meal.fromJsonString(v)));
    }

    final favStr = prefs.getStringList('favorites') ?? [];
    _favorites = favStr.map((s) => Meal.fromJsonString(s)).toList();

    _groceries = prefs.getStringList('groceries') ?? [];

    notifyListeners();
  }
}
