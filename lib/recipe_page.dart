import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class RecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pumpkin Soup'),
        actions: [
          Icon(FontAwesomeIcons.star)
        ],
      ),
      body: Column(
        children: [
          Expanded(child:
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('images/pumpkin_soup.jpeg')),
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ))
        ],
      ),
    );
  }
}
