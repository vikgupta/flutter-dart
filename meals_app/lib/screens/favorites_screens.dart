import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty) {
      return Center(
        child: Text('No Favorites Yet'),
      );
    } 

    return ListView.builder(
      itemBuilder: (ctx, index) {
        return MealItem(favoriteMeals[index], (id) {
          // do nothing
        });
      },
      itemCount: favoriteMeals.length,
    );
  }
}