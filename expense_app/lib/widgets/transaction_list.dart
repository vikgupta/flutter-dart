import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ? 
        Column(
          children: <Widget>[
            Text(
              'No transactions yet!', 
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            Container(
              height: 200,
              child: Image.asset(
                'assets/images/waiting.png', 
                fit: BoxFit.cover,
              ),
            ),
          ],
        ) :
        ListView.builder(
        itemBuilder: (ctx, index) {
          return Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10, 
                  horizontal: 15
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  )
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  '\$${transactions[index].amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: TextStyle(
                      color: Colors.grey
                    )
                  )
                ],
              ),
            ],
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}