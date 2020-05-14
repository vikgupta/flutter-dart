import 'dart:io';
import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getLocationAddress(location.latitude, location.longitude);

    final updatedLocation = PlaceLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address,
    );

    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      image: image,
      title: title,
      location: updatedLocation,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': updatedLocation.latitude,
      'loc_lng': updatedLocation.longitude,
      'address': address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final storedData = await DBHelper.getData('places');
    _items = storedData.map((item) => Place(
      id: item['id'],
      title: item['title'], 
      image: File(item['image']),
      location: PlaceLocation(
        latitude: item['loc_lat'],
        longitude: item['loc_lng'],
        address: item['address']
      ),
    )).toList();
    notifyListeners();
  } 
}