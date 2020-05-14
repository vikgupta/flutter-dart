import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './map_screen.dart';

import '../providers/great_places_provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const String routeName = '/place-details';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedPlace = Provider.of<GreatPlaces>(context, listen: false).fetchItemForId(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250, 
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1),
            ),
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            )
          ),
          SizedBox(height: 10,),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey
            ),
          ),
          SizedBox(height: 10,),
          FlatButton(
            child: Text('View Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapScreen(
                  initialLocation: selectedPlace.location, 
                  isSelecting: false,
                ),
              ));
            },
          )
        ],
      ),
    );
  }
}