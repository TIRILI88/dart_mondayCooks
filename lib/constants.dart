import 'package:flutter/material.dart';

const Color kColorContainer = Color(0xFF363636);
const Color kColorBackgroundDark = Color(0xFF212121);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);


ButtonStyle kElevatedButtonStyle = ElevatedButton.styleFrom(
  elevation: 10,
  minimumSize: Size(150.0, 50.0),
  primary: Colors.orangeAccent,
  onPrimary: Colors.white,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0)),
  textStyle: TextStyle(
    fontSize: 20,
  ),
);

