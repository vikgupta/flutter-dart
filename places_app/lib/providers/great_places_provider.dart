import 'dart:io';
import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      image: image,
      title: title,
      location: PlaceLocation(
        latitude: 0.0,
        longitude: 0.0,
      ),
    );

    _items.add(newPlace);
    notifyListeners();
  }
}