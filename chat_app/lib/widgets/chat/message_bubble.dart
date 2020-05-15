import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final message;
  final isMessageFromMyself;
  final Key key;

  MessageBubble(this.message, this.isMessageFromMyself, this.key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMessageFromMyself ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMessageFromMyself ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: isMessageFromMyself ? Radius.circular(12) : Radius.circular(0),
              bottomRight: isMessageFromMyself ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
              color: isMessageFromMyself ? Colors.black : Theme.of(context).accentTextTheme.headline1.color,
            ),
          ),
        ),
      ],
    );
  }
}