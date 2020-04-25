import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp()); // can be done for any function given there is only one expression

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  final _questions = const [
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
        body: _questionIndex < _questions.length ? 
          Quiz(
            answerQuestions: _answerQuestion,
            questionIndex: _questionIndex,
            questions: _questions,
          ) : 
          Result(),
      )
    );
  }
}