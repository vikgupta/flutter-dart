import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String userId, String authToken) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url = 'https://flutter-shop-app-1400d.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite
        ),
      );
      if(response.statusCode >= 400) {
        throw HttpException('Updating favorite status failed');
      }
    } catch(error) {
      // roll back
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}