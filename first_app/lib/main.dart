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
  final questions = const [
    {
      'questionText': 'Favorite Color?',
      'answers': ['Blue', 'Black', 'Red', 'Green']
    },
    {
      'questionText': 'Favorite Animal?',
      'answers': ['Dog', 'Cat', 'Tiger', 'Lion']
    },
    {
      'questionText': 'Favorite Instructor?',
      'answers': ['Max', 'Alex', 'VG', 'ABC']
    }
  ];

  void _answerQuestion() {
    setState(() {
      ++_questionIndex;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('First App'),),
        body: _questionIndex < questions.length ? Column(
          children: <Widget>[
            Question(
              questions[_questionIndex % questions.length]['questionText']
            ), 
            ...(questions[_questionIndex % questions.length]['answers'] as List<String>).map((answer) {
              return Answer(answer, _answerQuestion);
            }).toList()
          ]
        ) : Center(
          child: Text('No more questions!')
        ),
      )
    );
  }
}