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

  Future<void> fetchAndSetOrders() async {
    // Clear the list first
    _orders.clear();
    
    const url = 'https://flutter-shop-app-1400d.firebaseio.com/orders.json';
    try {
      final response = await http.get(url, headers: {});
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if(responseData == null) {
        return ;
      }
      responseData.forEach((orderId, data) {
        _orders.add(OrderItemModel(
          id: orderId,
          amount: data['amount'],
          dateTime: DateTime.parse(data['dateTime']),
          products: (data['products'] as List<dynamic>).map(
            (product) => CartItemModel(
              id: product['id'],
              title: product['title'],
              quantity: product['quantity'],
              price: product['price']
            )
          ).toList(),
        ));
      });
      notifyListeners();
    } catch(error) {
      throw error;
    } 
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