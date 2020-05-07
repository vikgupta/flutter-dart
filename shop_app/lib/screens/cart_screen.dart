import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$ ${cart.cartTotal}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color
                      )
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('Order Now'),
                    onPressed: () {},
                    textColor: Theme.of(context).primaryColor,
                  ),
                ]
              ),
            ),
          ),
          SizedBox(
            height: 10
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) {
                return CartItem(
                  cart.items.values.toList()[index].id,
                  cart.items.values.toList()[index].title,
                  cart.items.values.toList()[index].quantity,
                  cart.items.values.toList()[index].price,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}