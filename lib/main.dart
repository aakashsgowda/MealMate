import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/meal_provider.dart';
import 'pages/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final mealProvider = MealProvider();
  await mealProvider.loadData();

  runApp(
    ChangeNotifierProvider.value(
      value: mealProvider,
      child: const MealMateApp(),
    ),
  );
}

class MealMateApp extends StatelessWidget {
  const MealMateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealMate',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SplashScreen(),
    );
  }
}
