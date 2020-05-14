import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your chat'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('Test'),
        ),
        itemCount: 10,
      ),
    );
  }
}