import 'package:flutter/foundation.dart';

import './cart_provider.dart';

class OrderItemModel {
  final String id;
  final double amount;
  final List<CartItemModel> products;
  final DateTime dateTime;

  OrderItemModel({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime
  });
}

class Orders with ChangeNotifier {
  List<OrderItemModel> _orders = [];

  List<OrderItemModel> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItemModel> cartProducts, double total) {
    _orders.insert(
      0, 
      OrderItemModel(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts
      )
    );

    notifyListeners();
  }

  void clear() {
    _orders.clear();
    notifyListeners();
  }

}