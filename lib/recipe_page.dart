import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'recipe_class.dart';
import 'database.dart';


class RecipePage extends StatelessWidget {
  RecipePage({this.recipe});
  
  final Recipe recipe;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.recipeName),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Icon(FontAwesomeIcons.star))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'recipePicture',
              child: FutureBuilder(
                future: DataBaseService().getImage(context, recipe.recipeURL),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.done) {
                    return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.2,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width / 0.8,
                      child: snapshot.data,
                    );
                  }
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width / 1,
                      child: CircularProgressIndicator(
                      ),
                    );
                  }
                  return Container(
                    child: Text('ERROR',
                      style: TextStyle(
                          color: Colors.white
                      ),),
                  );
                },
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
                    child: Text('${recipe.recipeTime} MIN',
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
