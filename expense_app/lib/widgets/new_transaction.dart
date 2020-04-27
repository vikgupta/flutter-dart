import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransactionHandler;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTransactionHandler);

  void txHandler() {
    if(titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
      addTransactionHandler(titleController.text, amountController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end ,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              controller: titleController,
              onSubmitted: (_) => txHandler(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount'
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => txHandler(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: txHandler,
            ),
          ],
        ),
      ),
    );
  }
}