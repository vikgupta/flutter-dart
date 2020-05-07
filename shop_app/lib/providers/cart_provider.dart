import 'package:flutter/foundation.dart';

class CartItemModel {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItemModel({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price
  });
}

class Cart with ChangeNotifier{
  Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items {
    return {..._items};
  }

  void addItem(String productId, String title, double price) {
    _items.update(
      productId, 
      (cartItem) {
        return CartItemModel(
          id: cartItem.id,
          title: cartItem.title,
          quantity: cartItem.quantity + 1,
          price: cartItem.price
        );
      }, 
      ifAbsent: () {
        return CartItemModel(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price
        );
      }
    );

    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get cartTotal {
    double total = 0.0;
    _items.forEach((_, item) {
      total += (item.price * item.quantity);
    });

    return total;
  }
}