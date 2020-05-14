import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import './place_details_screen.dart';

import '../providers/great_places_provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places!'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshotData) {
          if(snapshotData.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Consumer<GreatPlaces>(
            child: Center(
              child: Text('Got no places yet!'),
            ),
            builder: (ctx, placesData, child) => placesData.items.length <= 0 ? child : ListView.builder(
              itemCount: placesData.items.length,
              itemBuilder: (ctx, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    placesData.items[index].image
                  ),
                ),
                title: Text(placesData.items[index].title),
                subtitle: Text(placesData.items[index].location.address),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    PlaceDetailsScreen.routeName,
                    arguments: placesData.items[index].id,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}