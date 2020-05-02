import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function removeTransactionHandler;
  
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.removeTransactionHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: TextStyle(
            color: Colors.grey
          )
        ),
        trailing: MediaQuery.of(context).size.width > 360 ? 
        FlatButton.icon(
          icon: Icon(Icons.delete),
          textColor: Theme.of(context).errorColor,
          label: Text('Delete'),
          onPressed: () => removeTransactionHandler(transaction.id),
        ):
        IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => removeTransactionHandler(transaction.id),
        ),
      ),
    );
  }
}