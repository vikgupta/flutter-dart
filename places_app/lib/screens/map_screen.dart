import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 12.933054,
      longitude: 77.685057,
      address: "Sobha Iris"
    ), 
    this.isSelecting = false
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectPlace(LatLng position) {
    print('_selectPlace called');
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if(widget.isSelecting) IconButton(
            icon: Icon(Icons.check),
            onPressed: _pickedLocation == null ? null : () {
              Navigator.of(context).pop(_pickedLocation); // _pickedLocation will be returned to the last screen
            },
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
          zoom: 17,
        ),
        onTap: widget.isSelecting ? _selectPlace : null,
        markers: (_pickedLocation == null && widget.isSelecting == true) ? null : {
          Marker(
            markerId: MarkerId('m1'),
            position: _pickedLocation ?? LatLng(
              widget.initialLocation.latitude, 
              widget.initialLocation.longitude
            ),
          )
        },
      ),
    );
  }
}