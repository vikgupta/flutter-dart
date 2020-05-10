import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders')
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (context, dataSnapshot) {
          if( dataSnapshot.connectionState == ConnectionState.waiting ) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if(dataSnapshot.error != null) {
              // Do error handling stuff
              return Center(
                child: Text('Error while fetching orders'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.ordersCount,
                  itemBuilder: (ctx, index) => OrderItem(orderData.orders[index]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}