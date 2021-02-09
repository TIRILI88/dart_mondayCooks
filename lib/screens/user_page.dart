import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../classes/default_data.dart';


class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  DefaultData.userName = 'There';
                });
            _auth.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil('/tabsPage', (Route<dynamic> route) => false);
          })
        ],
      ),
      body: Container(
        child: Text('Welcome'),
      ),
    );
  }
}
