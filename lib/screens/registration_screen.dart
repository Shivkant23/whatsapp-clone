// import 'package:country_pickers/country.dart';
// import 'package:country_pickers/country_pickers.dart';
import 'package:chat_app/authentication_service.dart';
import 'package:chat_app/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // static Country _selectedFilteredDialogCountry =
  //     CountryPickerUtils.getCountryByPhoneCode("92");
  // String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  String _phoneNumber="";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  TextEditingController _phoneAuthController = TextEditingController();

  @override
  void dispose() {
    _phoneAuthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(""),
                Text(
                  "Verify your Email and Password",
                  style: TextStyle(
                      fontSize: 18,
                      color: greenColor,
                      fontWeight: FontWeight.w500),
                ),
                Icon(Icons.more_vert)
              ],
            ),
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
              onPressed: (){
                context.read<AuthenticationService>().signIn(
                  email: emailController.text, password: passwordController.text
                );
              },
              child: Text("Signed In"),
            ),
          ],
        ),
      ),
    );
  }
}
