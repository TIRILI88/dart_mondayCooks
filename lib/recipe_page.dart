import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


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
          // SizedBox(height: 50),
          Expanded(
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('images/pumpkin_soup.jpeg')),
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SlidingUpPanel(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Color(0xFF363636),
            minHeight: 250,
            maxHeight: 600,
            padding: EdgeInsets.all(20),
            // backdropEnabled: true,
            header: Center(
              // heightFactor: 3,
              widthFactor: 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Recipe',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    )
                  ),
                  SizedBox(width: 150),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text('45 MIN',
                        style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        )),
                  )
                ],
              ),
            ),
            panel: Center(
              child:
                Text('Recipe Goes Here'),
            ),
          ),
        ],
      ),
    );
  }
}
