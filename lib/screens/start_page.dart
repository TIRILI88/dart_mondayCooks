import 'package:flutter/material.dart';
import 'package:monday_cooks/classes/debouncer_class.dart';
import 'package:monday_cooks/classes/recipe_class.dart';
import 'package:monday_cooks/screens/recipe_page.dart';
import 'package:monday_cooks/classes/category_class.dart';
import 'package:monday_cooks/database.dart';
import 'package:monday_cooks/components/dish_container.dart';
import 'package:monday_cooks/components/scroll_container.dart';
import 'package:monday_cooks/constants.dart';
import 'package:monday_cooks/classes/user_data_class.dart';
import 'dart:math';
import 'test_recipe_page.dart';


class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  List<Recipe> recipes = [Recipe('Burger', 'images/default_recipe.jpeg', 5.5, 25, 'Main Dish', 'Recipe Text here', '1999-01-01 00:01:00.000000', ['Tomato', 'Meat', 'Bread'], '5mjTOzKjEfeYSk9Fz3NV030WpTo2', '', '')];
  List<Recipe> filteredRecipes = [Recipe('Burger', 'images/default_recipe.jpeg', 5.5, 25, 'Main Dish', 'Recipe Text here', '1999-01-01 00:01:00.000000', ['Tomato', 'Meat', 'Bread'], '5mjTOzKjEfeYSk9Fz3NV030WpTo2', '', '')];
  List<Category> categories = [Category('Main Dish', false)];
  List<UserData> user = [UserData(userName: 'Test', userID: '')];
  final _debouncer = Debouncer(millisenconds: 500);
  bool isActive = false;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    DataBaseService().getCurrentUser().then((userFromServer) {
      setState(() {user = userFromServer;});
    });
    DataBaseService().getCategories().then((categoriesFromServer){
      setState(() {categories = categoriesFromServer;});
    });
    DataBaseService().getRecipes().then((recipesFromServer) {
      setState(() {
        recipes = recipesFromServer;
        filteredRecipes = recipes;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children:[
            Column(
              children: [
                // User Container
                Container(
                  height: 150,
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(kWelcomePhrases[0], //INSERT RANDOM NUMBER - WITHOUT RELOADING EVERYTHING TIME
                          style: kWelcomeTextField),
                      ),
                      SizedBox(height: 20),
                      Divider(
                          color: Colors.grey
                      )
                    ],
                  ),
                ),
                //New Dishes Container
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: TextField(
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'What are you looking for?'
                        ),
                      onChanged: (string) {
                          _debouncer.run((){
                            setState(() {
                              filteredRecipes = recipes.where((r) =>
                              (r.category.toLowerCase().contains(string.toLowerCase()) ||
                                  r.recipeText.toLowerCase().contains(string.toLowerCase()) ||
                                  r.recipeName.toLowerCase().contains(string.toLowerCase())
                                  // r.ingredients.toLowerCase().contains(string.toLowerCase()))
                              )).toList();
                            });
                          });
                      },
                    )
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Total dishes',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 20),
                      Text((filteredRecipes.length != null) ? filteredRecipes.length.toString() : '0',
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 20
                        ),)
                    ]
                  ),
                ),
                // Dish Category Slider
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  height: 80,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isActive = true;
                              print(isActive);
                            });
                          },
                          child: DishContainer(
                            category: categories[index].category,
                            isActive: categories[index].isActive = isActive,
                            onTap: () {
                              setState(() {
                                filteredRecipes = recipes.where((r) => r.category.contains(categories[index].category)).toList();
                                DishContainer().isActiveColor = Colors.orangeAccent;
                                // categories[index].isActive = true; ///TODO Set Active Color
                              });
                            },
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: 20),
                // Recipe Container Slider
                Expanded(child:
                ListView.builder(
                    itemCount: (recipes != null) ? filteredRecipes.length : 5,
                    itemBuilder: (BuildContext context, int index){
                      return FoodScrollContainer(
                        recipeName: filteredRecipes[index].recipeName,
                        scoreNumber: filteredRecipes[index].recipeScore,
                        cookingTime: filteredRecipes[index].cookTime,
                        imagePath: filteredRecipes[index].recipeURL,
                        onTapNavigation: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => TestRecipePage(recipe: filteredRecipes[index])));
                        },
                      );
                    }),
                  ),
                ],
            ),
        ]),
        );
  }
}

