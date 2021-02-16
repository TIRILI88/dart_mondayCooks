import 'package:flutter/material.dart';

class DialogAlert extends StatelessWidget {
  DialogAlert({@required this.message});

  final String message;

  @override
  Widget build(BuildContext context)  {
      return AlertDialog(
        title: Text('Something went wrong'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
            ),
        ],
      );

  }
}


