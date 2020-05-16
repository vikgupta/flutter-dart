import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMessageFromMyself;
  final Key key;
  final String userName;
  final String userImage;

  MessageBubble(this.message, this.userName, this.userImage, this.isMessageFromMyself, this.key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
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
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Column(
                crossAxisAlignment: isMessageFromMyself ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMessageFromMyself ? Colors.black : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMessageFromMyself ? Colors.black : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMessageFromMyself ? null : 125,
          right: isMessageFromMyself ? 125 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          )
        )
      ],
      overflow: Overflow.visible,
    );
  }
}