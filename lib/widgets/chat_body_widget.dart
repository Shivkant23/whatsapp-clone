
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<User> users;

  const ChatBodyWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(user: user),
                ));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.urlAvatar),
                backgroundColor: Colors.white,
              ),
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      user.name,
                      style: new TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text("${Utils.lastMessageDateTime(user.lastMessageTime)}",
                    style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                    maxLines: 1,
                  ),
                ],
              ),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: new Text(user.name,
                  style: new TextStyle(color: Colors.grey, fontSize: 15.0),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
        itemCount: users.length,
      );
}
