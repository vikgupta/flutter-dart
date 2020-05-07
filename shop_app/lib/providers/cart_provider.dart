import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price
  });
}

class Cart with ChangeNotifier{
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, String title, double price) {
    _items.update(
      productId, 
      (cartItem) {
        return CartItem(
          id: cartItem.id,
          title: cartItem.title,
          quantity: cartItem.quantity + 1,
          price: cartItem.price
        );
      }, 
      ifAbsent: () {
        return CartItem(
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