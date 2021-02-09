import 'package:flutter/material.dart';
import 'package:monday_cooks/debouncer_class.dart';
import 'package:monday_cooks/recipe_class.dart';
import 'package:monday_cooks/recipe_page.dart';
import 'database.dart';
import 'dish_container.dart';
import 'scroll_container.dart';
import 'constants.dart';
import 'category_class.dart';
import 'user_data.dart';
import 'dart:math';


class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  List<Recipe> recipes;
  List<Recipe> filteredRecipes;
  List<Category> categories;
  List<UserData> user;
  final _debouncer = Debouncer(millisenconds: 500);
  Random random = Random();
  // int randInt = ;

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
                                  r.recipeName.toLowerCase().contains(string.toLowerCase()) ||
                                  r.ingredients.toLowerCase().contains(string.toLowerCase()))
                              ).toList();
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
                      Text(
                        filteredRecipes.length.toString(),
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
                        return DishContainer(
                          category: categories[index].category,
                          onTap: () {
                            setState(() {
                              filteredRecipes = recipes.where((r) => r.category.contains(categories[index].category)).toList();
                            });
                          },
                        );
                      }
                  ),
                ),
                SizedBox(height: 20),
                // Recipe Container Slider
                Expanded(child:
                ListView.builder(
                    itemCount: filteredRecipes.length,
                    itemBuilder: (BuildContext context, int index){
                      return FoodScrollContainer(
                        recipeName: filteredRecipes[index].recipeName,
                        scoreNumber: filteredRecipes[index].recipeScore,
                        cookingTime: filteredRecipes[index].cookTime,
                        imagePath: filteredRecipes[index].recipeURL,
                        onTapNavigation: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RecipePage(recipe: filteredRecipes[index])));
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

