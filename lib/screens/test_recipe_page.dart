
import 'package:flutter/material.dart';
import 'package:monday_cooks/constants.dart';
import 'package:monday_cooks/components/recipe_image.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:monday_cooks/classes/recipe_class.dart';
import 'package:monday_cooks/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monday_cooks/screens/edit_page.dart';

///TODO Refactor to RecipePage - Delete original RecipePage
class TestRecipePage extends StatelessWidget {
  TestRecipePage({this.recipe});

  final _auth = FirebaseAuth.instance;
  final Recipe recipe;
  final double tabBarHeight = 80;
  List<String> ingredientsList;
  final PanelController recipePanelController = PanelController();
  final PanelController ingredientsPanelController = PanelController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.recipeName),
          actions: [
            ///TODO Decision: Edit TextButton - Appbar Icon
            ((_auth.currentUser.uid == recipe.userID)
                ? IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditPage()));
                  },) ///TODO Create edit function
                : Container()
            ),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                    onPressed: () {
                      recipe.favorite.contains(_auth.currentUser.uid) ? null : DataBaseService().addToFavorites(recipe.docID, _auth.currentUser.uid);
                    },
                    icon: recipe.favorite.contains(_auth.currentUser.uid) ? Icon(Icons.star_outlined) : Icon(Icons.star_border),
                  color: recipe.favorite.contains(_auth.currentUser.uid) ? Colors.orangeAccent : Colors.white,
                iconSize: 35,))
          ],
        ),
        body: Stack(
            children: [
              Column(
                children: [
                 /*
                  ((_auth.currentUser.uid == recipe.userID)
                      ? TextButton(
                        onPressed: () {},
                        child: Text('Edit'))
                      : Container()
                  ),
                  */
                  // Recipe Picture
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: RecipeImageWidget(imageName: recipe.recipeURL),
                    ),
                  ),
                  //Stars Field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: kColorContainer
                      ),
                        child: Center(
                          child: Text('⭐   ⭐   ⭐   ⭐   ⭐️', ///TODO Difficulty of recipe here
                          style: kWelcomeTextField.copyWith(fontSize: 30),),
                        )
                    ),
                  ),
                  SingleChildScrollView( ///TODO ListView for better read?
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF363636),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      height: MediaQuery.of(context).size.width * 0.9,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(recipe.recipeText)),
                  )
                ]),
              /* /// TODO Decision - ListView above - Second SlidingPanel underneath
              SlidingUpPanel(
                controller: recipePanelController,
                color: kColorContainer.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0)
                ),
                minHeight: MediaQuery.of(context).size.height * 0.25,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
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
              */
              //Ingredient Slider
              Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                  child: SlidingUpPanel(
                  controller: ingredientsPanelController,
                  color: kColorContainer.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)
                  ),
                  minHeight: MediaQuery.of(context).size.height * 0.13,
                  maxHeight: 500, //MediaQuery.of(context).size.height * 0.8,
                  panel: Container(
                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ingredientsPanelController.open();
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: Colors.grey
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text('Ingredients',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                  ),),
                                ],
                              ),
                            ),
                            SizedBox(height: 55),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: recipe.ingredients.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              child: Image(image: AssetImage(DataBaseService().getIngredientImage(recipe.ingredients[index])))),
                                            Text(recipe.ingredients[index]),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                ),
              ]),
            ]));
  }
}

