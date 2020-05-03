import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context).settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: Text(routeArguments['title']),
      ),
      body: Center(
        child: Text(routeArguments['id']),
      )
    );
  }
}