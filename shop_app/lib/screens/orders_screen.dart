import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders_provider.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if(_isInit) {
      // start showing the spinner
      setState(() {
        _isLoading = true;
      });
      
      Provider.of<Orders>(context).fetchAndSetOrders()
      .then((_) {
        // stop showing the spinner
        setState(() {
          _isLoading = false;
        });
      });

      _isInit = false;
    }
    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders')
      ),
      drawer: AppDrawer(),
      body: _isLoading ? 
        Center(
          child: CircularProgressIndicator(),
        ) :
        ListView.builder(
          itemCount: orders.ordersCount,
          itemBuilder: (ctx, index) => OrderItem(orders.orders[index]),
        )
    );
  }
}