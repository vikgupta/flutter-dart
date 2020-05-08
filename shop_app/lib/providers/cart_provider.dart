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

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if(!_items.containsKey(productId)) {
      return ;
    }

    if(_items[productId].quantity > 1) {
      _items.update(productId, (item) => CartItemModel(
        id: item.id,
        price: item.price,
        quantity: item.quantity - 1,
        title: item.title
      ));
    } else {
      _items.remove(productId);
    }
    
    notifyListeners();
  }
}