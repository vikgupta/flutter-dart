import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;

  Result(this.totalScore);

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
      child: Text(
        resultPhrase, 
        style: TextStyle(
          fontSize: 36, 
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      )
    );
  }
}