import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders')
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.ordersCount,
        itemBuilder: (ctx, index) => OrderItem(orders.orders[index]),
      )
    );
  }
}