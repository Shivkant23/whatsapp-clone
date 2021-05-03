import 'package:chat_app/authentication_service.dart';
import 'package:chat_app/pages/whatsapp_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email"
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password"
            ),
          ),
          RaisedButton(
            onPressed: ()async{
              String asd = await context.read<AuthenticationService>().signIn(
                email: emailController.text, password: passwordController.text
              );
              if(asd == "signin"){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WhatsAppHome(),
                  ),
                );
              }
            },
            child: Text("Signed In"),
          )
        ],
      ),
    );
  }
}