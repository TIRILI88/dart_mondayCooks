import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi User'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('default_recipe.jpeg')),
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(10)),

          ))
          )]
      ),
    );
  }
}
