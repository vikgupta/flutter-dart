import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransactionHandler;

  TransactionList(this.transactions, this.removeTransactionHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty ? 
        LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.1,
                child: Text(
                  'No transactions yet!', 
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
                width: double.infinity,
              ),
              Container(
                height: constraints.maxHeight * 0.85,
                child: Image.asset(
                  'assets/images/waiting.png', 
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        }) :
        ListView.builder(
        itemBuilder: (ctx, index) {
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
                      '\$${transactions[index].amount.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.title
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
                style: TextStyle(
                  color: Colors.grey
                )
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => removeTransactionHandler(transactions[index].id),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}