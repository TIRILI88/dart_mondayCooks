import 'package:flutter/material.dart';

class DialogAlert extends StatelessWidget {
  DialogAlert({@required this.title, @required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context)  {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
              TextButton(
                child: Text('OK',
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.orangeAccent
                ),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
            ),
        ],
      );

  }
}


