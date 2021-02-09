import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monday_cooks/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monday_cooks/default_data.dart';
import 'dialog_box.dart';
import 'database.dart';
import 'constants.dart';
import 'rounded_button.dart';


class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  final _firestore = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String name;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage('images/default_recipe.jpeg')),
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            Container(
              // borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: Color(0xFF363636).withOpacity(0.9),
              // minHeight: 200.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          name = value;
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Please give me your firstname')
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value;
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email address')
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password.')
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RoundedButton(
                            text: 'Log In',
                            color: Colors.orangeAccent,
                            onPressed: () async {
                              if(this.mounted) {
                                setState(() {
                                  showSpinner = true;
                                });
                              }
                              try {
                                final user = await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                                if (user != null) {
                                  Navigator.of(context).pushNamedAndRemoveUntil('/tabsPage', (Route<dynamic> route) => false);
                                }
                              }
                              catch (e) {
                                DialogAlert(message: e.toString());
                              }
                              if(this.mounted) {
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            }),
                        SizedBox(
                          width: 22.0,
                        ),
                        RoundedButton(
                            text: 'Sign Up',
                            color: Colors.orangeAccent,
                            onPressed: () async {
                              if(this.mounted) {
                                setState(() {
                                  showSpinner = true;
                                });
                              }
                              try {
                                final user = await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                                if (user != null) {
                                  DataBaseService().userName(name);
                                  setState(() {
                                    DefaultData.userName = name;
                                  });
                                  Navigator.of(context).pushNamedAndRemoveUntil('/tabsPage', (Route<dynamic> route) => false);
                                }
                              }
                              catch (e) {
                                DialogAlert(message: e.toString());
                              }
                              if(this.mounted) {
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            }),
                      ],
                    ),
                    SizedBox(height: 10,)
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
