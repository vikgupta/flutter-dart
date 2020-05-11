import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './product_provider.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;

  Products(this.authToken, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
     return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    // Clear the list first
    _items.clear();
    
    final url = 'https://flutter-shop-app-1400d.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url, headers: {});
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if(responseData == null) {
        return ;
      }
      responseData.forEach((prodId, data) {
        _items.add(Product(
          id: prodId,
          description: data['description'],
          title: data['title'],
          price: data['price'],
          imageUrl: data['imageUrl'],
          isFavorite: data['isFavorite'],
        ));
      });
      notifyListeners();
    } catch(error) {
      throw error;
    }
    
  }

  Future<void> addProduct(Product prod) async {
    final url = 'https://flutter-shop-app-1400d.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        headers: {},
        body: json.encode({
          'title': prod.title,
          'description': prod.description,
          'price': prod.price,
          'imageUrl': prod.imageUrl,
          'isFavorite': prod.isFavorite
        }),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: prod.title,
        description: prod.description,
        price: prod.price,
        imageUrl: prod.imageUrl
      );
      _items.add(newProduct);
      notifyListeners();
    } catch(error) {
      throw error;
    }
  }

  Future<void> updateProduct(Product prod) async {
    int index =_items.indexWhere((item) => item.id == prod.id);
    if(index >= 0) {
      // Update data on server too
      final url = 'https://flutter-shop-app-1400d.firebaseio.com/products/${prod.id}.json?auth=$authToken';
      await http.patch(
        url,
        body: json.encode({
          'title': prod.title,
          'description': prod.description,
          'price': prod.price,
          'imageUrl': prod.imageUrl,
        }),
      );

      _items[index] = prod;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productId) async {
    final existingIndex = _items.indexWhere((item) => item.id == productId);
    var existingProduct = _items[existingIndex];
    _items.removeAt(existingIndex);
    notifyListeners();

    final url = 'https://flutter-shop-app-1400d.firebaseio.com/products/$productId.json?auth=$authToken';
    final response = await http.delete(url);
    if(response.statusCode >= 400) {
      _items.insert(existingIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete the product!');
    } 

    existingProduct = null;
  }
}