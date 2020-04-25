import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Function clickHandler;

  Answer(this.answerText, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child: RaisedButton(
        child: Text(answerText),
        color: Colors.blueAccent,
        onPressed: clickHandler,
      ),
    );
  }
}