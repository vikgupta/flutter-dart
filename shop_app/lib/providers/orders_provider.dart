import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Future<void> addOrder(List<CartItemModel> cartProducts, double total) async {
    const url = 'https://flutter-shop-app-1400d.firebaseio.com/orders.json';
    final currentTime = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': currentTime.toIso8601String(),
          'products': cartProducts.map((cartProduct) => {
            'id': cartProduct.id,
            'title': cartProduct.title,
            'quantity': cartProduct.quantity,
            'price': cartProduct.price
          }).toList(),
        })
      );

      final newOrder = OrderItemModel(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: currentTime,
        products: cartProducts
      );

      _orders.insert(0, newOrder);
      notifyListeners();
    } catch(error) {
      throw error;
    }
  }

  void clear() {
    _orders.clear();
    notifyListeners();
  }

  int get ordersCount {
    return _orders.length;
  }
}