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
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}