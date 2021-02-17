import 'package:flutter/material.dart';
import 'package:monday_cooks/classes/recipe_class.dart';
import 'package:monday_cooks/database.dart';
import 'package:monday_cooks/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class EditPage extends StatelessWidget {
  EditPage({this.recipe});

  final Recipe recipe;
  int cookTime;
  double recipeScore;
  String recipeName;
  String ingredients;
  String recipeText;
  var concatenate = StringBuffer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorContainer,
        title: Text('Edit your recipe')
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/default_recipe.jpeg'),
              fit: BoxFit.cover,
            )
        ),
        child: Container(
          decoration: BoxDecoration(
              color: kColorContainer.withOpacity(0.85)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60),
                // Category Dropdown
                // Row: Cooking Time + Score
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          initialValue: recipe.cookTime.toString(),
                          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                          textAlign: TextAlign.center,
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Cooking Time'),
                          onChanged: (cookTimeValue) {
                            cookTime = int.parse(cookTimeValue);
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        child: TextFormField(
                          initialValue: recipe.recipeScore.toString(),
                          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                          textAlign: TextAlign.center,
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Your Score'),
                          onChanged: (scoreValue) {
                            recipeScore = double.parse(scoreValue);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Recipe Name Text
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: recipe.recipeName,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Recipe Name'),
                    onChanged: (recipeValue) {
                      recipeName = recipeValue;
                    },
                  ),
                ),
                // Ingredients Text
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: recipe.ingredients.toString(),
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Ingredients'),
                    onChanged: (ingredientValue) {
                      ingredients = ingredientValue;
                    },
                  ),
                ),

                // Recipe Step Text
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.orangeAccent),
                        borderRadius: BorderRadius.all(Radius.circular(32.0))
                    ),
                    height: 200.0,
                    child: TextFormField(
                      initialValue: recipe.recipeText,
                      maxLines: 10,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Recipe Steps',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      ),
                      onChanged: (recipeTextValue) {
                        recipeText = recipeTextValue;
                      },
                    ),
                  ),
                ),

                //Row camera Buttons
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Gallery Button
                        ElevatedButton(
                            style: kElevatedButtonStyle,
                            child: Icon(FontAwesomeIcons.images,
                              size: 40,),
                            onPressed: (){
                              // getImage(ImageSource.gallery);
                            }),
                        // Camera Button
                        ElevatedButton(
                            style: kElevatedButtonStyle,
                            child: Icon(FontAwesomeIcons.cameraRetro),
                            onPressed: (){
                              // getImage(ImageSource.gallery);
                            }),
                      ]),
                ),
                // Upload Button
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ButtonTheme(
                    minWidth: 200,
                    child: ElevatedButton(
                      style: kElevatedButtonStyle,
                      onPressed: () {
                        DataBaseService().editRecipe(context, recipe.docID, recipe.category, recipeName, recipe.recipeURL, ingredients, cookTime, recipeScore, recipeText);
                      },
                      child: Text('Finish Editing'),
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
