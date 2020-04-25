import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

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
            Text(
              questions[_questionIndex % questions.length]
            ), 
            RaisedButton(
              child: Text('Answer 1'), 
              onPressed: _answerQuestion,
            ),
            RaisedButton(
              child: Text('Answer 2'), 
              // onPressed: () {
              //   print('Answer 2 chosen');
              // },
              onPressed: _answerQuestion,
            ),
            RaisedButton(
              child: Text('Answer 3'), 
              //onPressed: () => print('Answer 3 chosen'),
              onPressed: _answerQuestion,
            ),
          ]
        ),
      )
    );
  }
}