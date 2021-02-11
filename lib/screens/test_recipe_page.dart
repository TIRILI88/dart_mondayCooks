import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/classes/ingredient_class.dart';
import 'package:monday_cooks/constants.dart';
import 'package:monday_cooks/components/recipe_image.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:monday_cooks/components/tab_widget.dart';
import 'package:monday_cooks/classes/recipe_class.dart';

class TestRecipePage extends StatelessWidget {
  TestRecipePage({this.recipe});

  final Recipe recipe;
  final double tabBarHeight = 80;
  List<String> ingredientsList;
  final recipePanelController = PanelController();
  final ingredientsPanelController = PanelController();


  getIngredientImage(fileName) {
    var syncPath = 'images/ingredient_icons/${fileName.toLowerCase()}.png';
    if (File(syncPath).exists() != null) {
      return syncPath;
    } else {
      return 'images/ingredient_icons/carrot.png';
    }
  }

  // makeIngredientGrid()
  // List<Ingredients> options = [
  //   Ingredients(ingredient: )
  //
  //
  // ];


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
        body: Stack(
            children: [
              Center(child: RecipeImageWidget(imageName: recipe.recipeURL)),
              SlidingUpPanel(
                controller: recipePanelController,
                color: kColorContainer.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0)
                ),
                minHeight: MediaQuery.of(context).size.height * 0.25,
                maxHeight: 800, //MediaQuery.of(context).size.height * 0.8,
                panel: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  child: Container(
                      child:
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              recipePanelController.open();
                            },
                            child: Text('Recipe',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),),
                          ),
                          SizedBox(height: 80,),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                                child: Text(recipe.recipeText),
                            ),
                          ),
                        ],
                      )),
                ),
                // body: Text(recipe.recipeText),//
              ),
              SlidingUpPanel(
                controller: ingredientsPanelController,
                color: kColorContainer,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0)
                ),
                minHeight: MediaQuery.of(context).size.height * 0.15,
                maxHeight: 500, //MediaQuery.of(context).size.height * 0.8,
                panel: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  child: Container(
                      child:
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ingredientsPanelController.open();
                              },
                              child: Text('Ingredients',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                              ),),
                            ),
                            // SizedBox(height: 80,),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(child:
                              Column(
                                children: [
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: recipe.ingredients.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Container(
                                            height: 50,
                                            width: 50,
                                            child: Image(image: AssetImage(getIngredientImage(recipe.ingredients[index]))));
                                      }),
                                  Text(recipe.ingredients.toString()),
                                ],
                              ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                // body: Text(recipe.recipeText),//
              ),
            ]));
  }
}

