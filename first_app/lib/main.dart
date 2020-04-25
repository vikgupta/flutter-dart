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
  var _totalScore = 0;
  final _questions = const [
    {
      'questionText': 'Favorite Color?',
      'answers': 
      [
        {
          'text': 'Blue', 
          'score': 1
        },
        {
          'text': 'Black', 
          'score': 2
        },
        { 
          'text': 'Red', 
          'score': 3
        }, 
        {
          'text': 'Green', 
          'score': 4
        }
      ]
    },
    {
      'questionText': 'Favorite Animal?',
      'answers': 
      [
        {
          'text': 'Dog', 
          'score': 1
        },
        {
          'text': 'Cat', 
          'score': 2
        },
        { 
          'text': 'Lion', 
          'score': 3
        }, 
        {
          'text': 'Tiger', 
          'score': 4
        }
      ]
    },
    {
      'questionText': 'Favorite Instructor?',
      'answers': 
      [
        {
          'text': 'A', 
          'score': 1
        },
        {
          'text': 'B', 
          'score': 2
        },
        { 
          'text': 'C', 
          'score': 3
        }, 
        {
          'text': 'D', 
          'score': 4
        }
      ]
    }
  ];

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      ++_questionIndex;
    });
  }

  void _resetQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
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
          Result(_totalScore, _resetQuiz),
      )
    );
  }
}