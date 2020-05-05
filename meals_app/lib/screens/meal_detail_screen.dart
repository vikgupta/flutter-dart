import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-details';
  final Function toggleFavorite;
  final Function isMealFavorite;

  MealDetailScreen(this.toggleFavorite, this.isMealFavorite);

  Widget buildImageContainer(context, imageUrl) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildSectionTitle(context, sectionTitle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        sectionTitle,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(context, child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildImageContainer(context, meal.imageUrl),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(context, ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(meal.ingredients[index])),
                  );
                },
                itemCount: meal.ingredients.length,
              )
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(context, ListView.builder(
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}')
                      ),
                      title: Text(meal.steps[index]),
                    ),
                    Divider(),
                  ],
                );
              },
              itemCount: meal.steps.length,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFavorite(meal.id) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          //Navigator.of(context).pop(meal.id);
          toggleFavorite(meal.id);
        },
      ),
    );
  }
}