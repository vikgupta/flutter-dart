import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransaction(this.addTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _txHandler() {
    if(_titleController.text.isEmpty || _amountController.text.isEmpty || _selectedDate == null) {
      return;
    }
    
    // widget is available to get handle of the underlying widget
    widget.addTransactionHandler(_titleController.text, _amountController.text, _selectedDate);

    // context is available to get the context property of the underlying widget
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()
    ).then((date) {
      if(date != null) {
        setState(() {
          _selectedDate = date;
        }); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              left:10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end ,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Title'
                  ),
                  controller: _titleController,
                  onSubmitted: (_) => _txHandler(),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Amount'
                  ),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _txHandler(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_selectedDate == null ? 
                          'No Date chosen' : 
                          'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                      ),
                      Platform.isIOS ? 
                        CupertinoButton(
                          color: Colors.purple,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          onPressed: _presentDatePicker,
                        ):
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          onPressed: _presentDatePicker,
                        ),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _txHandler,
                ),
              ],
            ),
          ),
      ),
    );
  }
}