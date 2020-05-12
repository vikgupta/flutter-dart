import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart';

class OrderItem extends StatefulWidget {
  final OrderItemModel orderItem;

  OrderItem(this.orderItem);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: _expanded ? min(widget.orderItem.products.length * 20.0 + 150, 200) : 100,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$ ${widget.orderItem.amount}'),
              subtitle: Text(DateFormat.yMMMd().format(widget.orderItem.dateTime)),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded ? min(widget.orderItem.products.length * 20.0 + 55, 100) : 0,
              child: ListView.builder(
                itemCount: widget.orderItem.products.length,
                itemBuilder: (ctx, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.orderItem.products[index].title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '${widget.orderItem.products[index].quantity} x \$${widget.orderItem.products[index].price}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}