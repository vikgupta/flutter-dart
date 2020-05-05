import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal> _categoryMeals;
  String _categoryTitle;
  bool _initDataLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override 
  void didChangeDependencies() {
    if(!_initDataLoaded) {
      final routeArguments = ModalRoute.of(context).settings.arguments as Map<String, String>;
      _categoryTitle = routeArguments['title'];
      final categoryId = routeArguments['id'];
      _categoryMeals = widget.availableMeals.where((meal) => meal.categories.contains(categoryId)).toList();
      _initDataLoaded = true;
    }

    super.didChangeDependencies();
  }

  void _removeItem(String id) {
    setState(() {
      _categoryMeals.removeWhere((meal) => meal.id == id);  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(_categoryMeals[index], _removeItem);
        },
        itemCount: _categoryMeals.length,
      ),
    );
  }
}