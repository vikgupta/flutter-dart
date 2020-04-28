import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for(var transaction in recentTransactions) {
        if(transaction.date.day == weekDay.day && 
          transaction.date.month == weekDay.month &&
          transaction.date.year == weekDay.year) {
            totalSum += transaction.amount;
          }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum, 
      };
    });
  }

  double get totalSpending {
    // double spending = 0.0;
    // for(var transaction in groupedTransactions) {
    //   spending += transaction['amount'];
    // }

    // return spending;

    // alternate way
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingPercent: totalSpending > 0 ? (data['amount'] as double) / totalSpending : 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}