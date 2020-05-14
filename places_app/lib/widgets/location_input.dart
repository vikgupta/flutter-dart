import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/map_screen.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    if(locationData != null) {
      setState(() {
        _previewImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude: locationData.latitude, 
          longitude: locationData.longitude
        );
      });
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(isSelecting: true,),
      ),
    );

    if(selectedLocation == null) {
      return;
    }

    print(selectedLocation.latitude);
    print(selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null ? 
            Text(
              'No Location chosen',
              textAlign: TextAlign.center,
            ) :
            Image.network(
              _previewImageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on), 
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation, 
            ),
            FlatButton.icon(
              icon: Icon(Icons.map), 
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap, 
            ),
          ],
        ),
      ],
    );
  }
}