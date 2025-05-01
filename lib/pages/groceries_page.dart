import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/meal_provider.dart';
import '../models/meal.dart';

class GroceriesPage extends StatefulWidget {
  const GroceriesPage({Key? key}) : super(key: key);

  @override
  State<GroceriesPage> createState() => _GroceriesPageState();
}

class _GroceriesPageState extends State<GroceriesPage> {
  Meal? _selectedMeal;
  final Set<String> _checkedItems = {};
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _loadCheckedItems();
  }

  Future<void> _loadCheckedItems() async {
    _prefs = await SharedPreferences.getInstance();
    final stored = _prefs?.getStringList('checkedGroceries') ?? [];
    setState(() {
      _checkedItems.addAll(stored);
    });
  }

  Future<void> _saveCheckedItems() async {
    await _prefs?.setStringList('checkedGroceries', _checkedItems.toList());
  }

  void _toggleChecked(String item, bool checked) {
    setState(() {
      if (checked) {
        _checkedItems.add(item);
      } else {
        _checkedItems.remove(item);
      }
      _saveCheckedItems();
    });
  }

  void _markAll(List<String> ingredients) {
    setState(() {
      _checkedItems.addAll(ingredients);
      _saveCheckedItems();
    });
  }

  void _unmarkAll(List<String> ingredients) {
    setState(() {
      _checkedItems.removeAll(ingredients);
      _saveCheckedItems();
    });
  }

  void _clearMealSelection() {
    setState(() {
      _selectedMeal = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context);
    final plannerMeals = provider.planner.values.toSet().toList();
    final ingredients = _selectedMeal?.ingredients ?? [];

    bool isAllMarked = ingredients.isNotEmpty &&
        ingredients.every((item) => _checkedItems.contains(item));

    return Scaffold(
      appBar: AppBar(title: const Text('Groceries List')),
      body: Column(
        children: [
          // Meal Dropdown
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<Meal>(
              isExpanded: true,
              value: _selectedMeal,
              hint: const Text('Select a meal'),
              onChanged: (Meal? meal) {
                setState(() {
                  _selectedMeal = meal;
                });
              },
              items: plannerMeals.map((meal) {
                return DropdownMenuItem<Meal>(
                  value: meal,
                  child: Text(meal.name),
                );
              }).toList(),
            ),
          ),

          // Control buttons
          if (_selectedMeal != null) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    isAllMarked ? _unmarkAll(ingredients) : _markAll(ingredients);
                  },
                  icon: Icon(isAllMarked ? Icons.close : Icons.check_circle_outline),
                  label: Text(isAllMarked ? 'Unmark All' : 'Mark All'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: _clearMealSelection,
                  child: const Text('Clear Meal'),
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Groceries list
          Expanded(
            child: ingredients.isEmpty
                ? const Center(child: Text('No ingredients for the selected meal.'))
                : ListView.builder(
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      final item = ingredients[index];
                      final checked = _checkedItems.contains(item);

                      return CheckboxListTile(
                        value: checked,
                        onChanged: (value) => _toggleChecked(item, value!),
                        title: Text(item),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.green,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
