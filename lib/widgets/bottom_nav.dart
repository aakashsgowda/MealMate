import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/planner_page.dart';
import '../pages/favorites_page.dart';
import '../pages/groceries_page.dart';

class BottomNavScaffold extends StatefulWidget {
  const BottomNavScaffold({Key? key}) : super(key: key);

  @override
  State<BottomNavScaffold> createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    PlannerPage(),
    FavoritesPage(),
    GroceriesPage(),
  ];

  final List<String> _titles = const [
    'MealMate',
    'Planner',
    'Favorites',
    'Groceries',
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Planner'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Groceries'),
        ],
      ),
    );
  }
}
