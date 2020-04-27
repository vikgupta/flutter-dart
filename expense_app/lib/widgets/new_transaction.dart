import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransactionHandler;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTransactionHandler);

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
              //onChanged: (value) => titleInput = value,
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount'
              ),
              //onChanged: (value) => amountInput = value,
              controller: amountController,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: () {
                //print(titleController.text);
                //print(amountController.text);
                addTransactionHandler(titleController.text, amountController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}