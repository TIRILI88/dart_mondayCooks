import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/components/scroll_container.dart';
import 'package:monday_cooks/constants.dart';
import 'package:monday_cooks/classes/user_data_class.dart';
import 'package:monday_cooks/database.dart';
import 'package:monday_cooks/classes/recipe_class.dart';
import 'package:monday_cooks/screens/test_recipe_page.dart';


class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  final _auth = FirebaseAuth.instance;
  List<UserData> user = [UserData(userName: 'Test', userID: '')];
  List<Recipe> recipes = [Recipe('Burger', 'images/default_recipe.jpeg', 5.5, 25, 'Main Dish', 'Recipe Text here', '1999-01-01 00:01:00.000000', ['Tomato', 'Meat', 'Bread'], '5mjTOzKjEfeYSk9Fz3NV030WpTo2', '', '')];
  List<Recipe> userRecipes = [Recipe('Burger', 'images/default_recipe.jpeg', 5.5, 25, 'Main Dish', 'Recipe Text here', '1999-01-01 00:01:00.000000', ['Tomato', 'Meat', 'Bread'], '5mjTOzKjEfeYSk9Fz3NV030WpTo2', '', '')];
  List<Recipe> favoriteRecipes = [Recipe('Burger', 'images/default_recipe.jpeg', 5.5, 25, 'Main Dish', 'Recipe Text here', '1999-01-01 00:01:00.000000', ['Tomato', 'Meat', 'Bread'], '5mjTOzKjEfeYSk9Fz3NV030WpTo2', '', '')];


  @override
  void initState() {
    super.initState();
    DataBaseService().getCurrentUser().then((userFromServer) {
      setState(() {user = userFromServer;});
    });
    DataBaseService().getRecipes().then((recipesFromServer) {
      setState(() {
        recipes = recipesFromServer;
        userRecipes = recipes.where((r) => r.userID.contains(_auth.currentUser.uid)).toList();
        favoriteRecipes = recipes.where((r) => r.favorite.contains(_auth.currentUser.uid)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Your Recipes, ${user[0].userName} ', //
                    style: kWelcomeTextField.copyWith(fontSize: 22),),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.orangeAccent,
                      ),
                        child: Icon(FontAwesomeIcons.signOutAlt),
                        onPressed: () {
                          _auth.signOut();
                          Navigator.pushNamed(context, '/tabsPage');
                        },
                    ),
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: (recipes != null) ? userRecipes.length : 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 200,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(userRecipes[index].recipeName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),),
                                    SizedBox(height: 5.0,),
                                    Text(userRecipes[index].recipeScore.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                ),
                ),
                Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Your Favorites',
                        textAlign: TextAlign.left,
                        style: kWelcomeTextField.copyWith(fontSize: 22),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: favoriteRecipes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FoodScrollContainer(
                                recipeName: favoriteRecipes[index].recipeName,
                                scoreNumber: favoriteRecipes[index].recipeScore,
                                cookingTime: favoriteRecipes[index].cookTime,
                                imagePath: favoriteRecipes[index].recipeURL,
                                  onTapNavigation: () {
                                  MaterialPageRoute(builder: (context) => TestRecipePage(recipe: favoriteRecipes[index],));
                                  },
                              );
                            }
                            /*
                            recipeName: filteredRecipes[index].recipeName,
                          scoreNumber: filteredRecipes[index].recipeScore,
                          cookingTime: filteredRecipes[index].cookTime,
                          imagePath: filteredRecipes[index].recipeURL,
                          onTapNavigation: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => TestRecipePage(recipe: filteredRecipes[index])));
                          },
                             */
                        ),
                      )
                    ],
                  ),
                ),
                  ),
              ]),
            )
          ] //
        ),
      ),
    );
  }
}
