import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:monday_cooks/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monday_cooks/components/dialog_box.dart';
import 'package:monday_cooks/constants.dart';
import 'package:monday_cooks/components/rounded_button.dart';
import 'package:monday_cooks/classes/user_data_class.dart';


class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String name;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
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
                          textCapitalization: TextCapitalization.words,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            name = value;
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
                          },
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password.')
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                if (name != '' && email != '' && password != '') {
                                  try {
                                    final user = await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                    if (user != null) {
                                      DataBaseService().getCurrentUser();
                                      Navigator.of(context).pushNamedAndRemoveUntil('/tabsPage', (Route<dynamic> route) => false);
                                    }
                                  }
                                  catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogAlert(title: 'Something went wrong', message: e.toString());
                                        }
                                    );
                                  }
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogAlert(title: 'Not Enough Information', message: 'Please fill all fields');
                                      }
                                  );
                                }
                                if(this.mounted) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                              }),
                          RoundedButton(
                              text: 'Sign Up',
                              color: Colors.orangeAccent,
                              onPressed: () async {
                                if(this.mounted) {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                }
                                if (name != '' && email != '' && password != '') {
                                  try {
                                    final user = await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                    if (user != null) {
                                      await DataBaseService().userName(name);
                                      await DataBaseService().getCurrentUser();
                                      Navigator.of(context).pushNamedAndRemoveUntil('/tabsPage', (Route<dynamic> route) => false);
                                    }
                                  }
                                  catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogAlert(title: 'Something went wrong', message: e.toString());
                                        }
                                    );
                                  }
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogAlert(title: 'Not Enough Information', message: 'Please fill all required fields');
                                      }
                                  );
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
      ),
    );
  }
}
