
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/widgets/messages_widget.dart';
import 'package:chat_app/widgets/new_message_widget.dart';
import 'package:chat_app/widgets/profile_header_widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Theme.of(context).primaryColor,
    body: SafeArea(
      child: Column(
        children: [
          ProfileHeaderWidget(name: widget.user.name, imageurl: widget.user.urlAvatar),
          Expanded(
            child: Container(
              // padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      "assets/background_wallpaper.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: MessagesWidget(idUser: widget.user.idUser),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: NewMessageWidget(idUser: widget.user.idUser),
                  ),
                ],
              ),
            ),
          ),
          
        ],
      ),
    ),
  );
}
