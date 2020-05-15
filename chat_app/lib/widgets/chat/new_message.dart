import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _messageController = TextEditingController();

  void _sendMessage() {
    //FocusScope.of(context).unfocus();

    Firestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Type a message',
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value.trim();
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}