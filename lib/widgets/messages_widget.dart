
import 'package:chat_app/core/api/firebse_api.dart';
import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/data.dart';
import 'package:chat_app/widgets/message_widget.dart';
import 'package:flutter/material.dart';

class MessagesWidget extends StatefulWidget {
  final String idUser;

  MessagesWidget({
    @required this.idUser,
    Key key,
  }) : super(key: key);

  @override
  _MessagesWidgetState createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  ScrollController _scrollController= new ScrollController();
  Message lastMessageObj;
  List<Message> listOfMessages = [];
  List<Message> listOfMsg = [];
  double delta = 430, beta = 430;
  int lastIndexFlag = 0;

  @override
  void initState() {
    super.initState();
    getMessages();

    _scrollController.addListener(() {
      double currentScroll = _scrollController.position.pixels;
      if(currentScroll >= delta){
        getMoreMessages();
        delta = delta + 430;
        beta = delta;
      }
      if(currentScroll <= beta){
        getMoreMessages();
        beta = beta - 430;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    lastIndexFlag = 0;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return (listOfMessages.isNotEmpty && listOfMessages.length > 0) ? ListView.builder(
  //     controller: _scrollController,
  //     physics: BouncingScrollPhysics(),
  //     reverse: true,
  //     itemCount: listOfMessages.length,
  //     itemBuilder: (context, index) {
  //       final message = listOfMessages[index];
  //       return MessageWidget(
  //         message: message,
  //         isMe: message.idUser == myId,
  //       );
  //     },
  //   ): Center(child: CircularProgressIndicator());;
  // }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: FirebaseApi.getMessages(widget.idUser),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;
                lastMessageObj = snapshot.data.last;

                return ListView.builder(
                  controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return MessageWidget(
                            message: message,
                            isMe: message.idUser == myId,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );

  getMoreMessages(){
    Stream<List<Message>> response = FirebaseApi.getMoreMessages(widget.idUser, lastMessageObj);
    if(response != null){
      listOfMessages.clear();
      response.forEach((element) {
        setState(() {
          listOfMessages = element;
          lastMessageObj = element.last;
        });
      });
    }
  }

  getMessages(){
    Stream<List<Message>> response = FirebaseApi.getMessages(widget.idUser);
    if(response != null){
      listOfMessages.clear();
      response.forEach((element) {
        setState(() {
          // listOfMsg = element;
          listOfMessages = element;
          lastMessageObj = element.last;
          // addMessagesInList(true);
        });
      });
    }
  }

  // addMessagesInList(bool needToIncrement){
  //   int limit = needToIncrement ? lastIndexFlag + 10 : lastIndexFlag - 15;
  //   listOfMessages.clear();
  //   for(int i = lastIndexFlag; i < limit; i++){
  //     listOfMessages.add(listOfMsg[i]);
  //     lastIndexFlag = i;
  //   }
  //   setState(() {
      
  //   });
  //   print("lastIndexFlag: $lastIndexFlag");
  // }
}
