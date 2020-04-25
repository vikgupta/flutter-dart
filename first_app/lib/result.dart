import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final Function resetQuiz;

  Result(this.totalScore, this.resetQuiz);

  String get resultPhrase {
    var result = 'You did it!';

    if(totalScore < 8) {
      result = 'Less than 8';
    } else if (totalScore < 12) {
      result = 'Less than 12';
    } else {
      result = 'Greater than 12';
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase, 
            style: TextStyle(
              fontSize: 36, 
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text('Restart Quiz!'),
            onPressed: resetQuiz,
          ),
        ],
      )
    );
  }
}