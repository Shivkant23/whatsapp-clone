
import 'package:chat_app/core/api/firebse_api.dart';
import 'package:chat_app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;

  const NewMessageWidget({
    @required this.idUser,
    Key key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();

    await FirebaseApi.uploadMessage(widget.idUser, message);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
        // color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Icon(Icons.tag_faces_outlined, color: iconBrownColor,),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextField(
                          controller: _controller,
                          textCapitalization: TextCapitalization.sentences,
                          autocorrect: true,
                          // enableSuggestions: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Type your message',
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none
                          ),
                          onChanged: (value) => setState(() {
                            message = value;
                          }),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.attach_file, color: iconBrownColor,),
                    SizedBox(width: 10),
                    _controller.text.isEmpty ? 
                    Row(
                      children: [
                        Icon(Icons.camera_alt, color: iconBrownColor,),
                        SizedBox(width: 15),
                      ],
                    ): Container(),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: Icon(_controller.text.isEmpty ? Icons.mic : Icons.send, color: Colors.white, size: 25,),
              ),
            ),
          ],
        ),
      );
}
