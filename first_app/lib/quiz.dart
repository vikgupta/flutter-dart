import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final questions;
  final int questionIndex;
  final Function answerQuestions;

  Quiz({
    @required this.questions, 
    @required this.answerQuestions, 
    @required this.questionIndex
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(
          questions[questionIndex]['questionText']
        ), 
        ...(questions[questionIndex]['answers'] as List<String>).map((answer) {
          return Answer(answer, answerQuestions);
        }).toList()
      ]
    );
  }
}