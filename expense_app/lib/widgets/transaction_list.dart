import 'package:flutter/material.dart';

import './transaction_item.dart';
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
        ListView(
          children: transactions.map((tx) => TransactionItem(
              key: ValueKey(tx.id),
              transaction: tx, 
              removeTransactionHandler: removeTransactionHandler
              )
            ).toList()
      ),
    );
  }
}