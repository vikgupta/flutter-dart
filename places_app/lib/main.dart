import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/add_place_screen.dart';
import './screens/places_list_screen.dart';

import './providers/great_places_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        //home: PlacesListScreen(),
        routes: {
          PlacesListScreen.routeName: (ctx) => PlacesListScreen(),
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen()
        },
      ),
    );
  }
}
