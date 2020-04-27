import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransaction(this.addTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void txHandler() {
    if(titleController.text.isEmpty || amountController.text.isEmpty) {
      return;
    }
    
    // widget is available to get handle of the underlying widget
    widget.addTransactionHandler(titleController.text, amountController.text);

    // context is available to get the context property of the underlying widget
    Navigator.of(context).pop();
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