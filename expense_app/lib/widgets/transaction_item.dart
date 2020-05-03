import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function removeTransactionHandler;
  
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.removeTransactionHandler,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  final _availableColors = [
    Colors.black,
    Colors.blue,
    Colors.purple,
    Colors.green
  ];

  @override
  void initState() {
    _bgColor = _availableColors[Random().nextInt(_availableColors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${widget.transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: TextStyle(
            color: Colors.grey
          )
        ),
        trailing: MediaQuery.of(context).size.width > 360 ? 
        FlatButton.icon(
          icon: Icon(Icons.delete),
          textColor: Theme.of(context).errorColor,
          label: Text('Delete'),
          onPressed: () => widget.removeTransactionHandler(widget.transaction.id),
        ):
        IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.removeTransactionHandler(widget.transaction.id),
        ),
      ),
    );
  }
}