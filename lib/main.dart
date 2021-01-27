import 'package:flutter/material.dart';
import 'start_page.dart';

void main() {
  runApp(MondayCooks());
}

class MondayCooks extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF212121),
        scaffoldBackgroundColor: Color(0xFF212121),
      ),
      home: StartPage(),
    );
  }
}


