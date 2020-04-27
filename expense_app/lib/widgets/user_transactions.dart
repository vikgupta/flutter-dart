import 'package:flutter/material.dart';

// import the needed widgets
import './new_transaction.dart';
import './transaction_list.dart';

// import the needed models
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1', 
      title: 'Dinner', 
      amount: 12.34, 
      date: DateTime.now()
    ),
    Transaction(
      id: 't2', 
      title: 'Shirt', 
      amount: 9.49, 
      date: DateTime.now()
    ),
  ];

  void _addNewTransaction(String txTitle, String txAmount) {
    final newTx = Transaction(
      title: txTitle, 
      amount: double.parse(txAmount), 
      date: DateTime.now(),
      id: DateTime.now().toString()
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions)
      ],
    );
  }
}