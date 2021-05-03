import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/utils/style.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageWidget({
    @required this.message,
    @required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);
    var width = MediaQuery.of(context).size.width - 100;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        // if (!isMe)
        //   CircleAvatar(
        //       radius: 16, backgroundImage: NetworkImage(message.urlAvatar)),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          constraints: BoxConstraints(maxWidth: width),
          decoration: BoxDecoration(
            color: isMe ? myMessageColor : Colors.white,
            borderRadius: isMe
                ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:  CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            message.message,
            style: TextStyle(color: Colors.black, fontSize: 16),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 2),
          Text("${Utils.fromDateTimeToText(message.createdAt)}",
            style: TextStyle(color: Colors.black45, fontSize: 13),
            textAlign: TextAlign.start,
          ),
        ],
      );
}
