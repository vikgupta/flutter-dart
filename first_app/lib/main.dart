import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

void main() => runApp(MyApp()); // can be done for any function given there is only one expression

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {
      ++_questionIndex;
    });
    print('Answer chosen');
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      'Favorite Color?',
      'Favorite Animal?',
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('First App'),),
        body: Column(
          children: <Widget>[
            Question(
              questions[_questionIndex % questions.length]
            ), 
            Answer(
              'Answer 1',
              _answerQuestion,
            ),
            Answer(
              'Answer 2',
              _answerQuestion,
            ),
            Answer(
              'Answer 3',
              _answerQuestion,
            ),
          ]
        ),
      )
    );
  }
}