import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/components/future_builder_images.dart';
import 'package:monday_cooks/components/scroll_container.dart';
import 'package:monday_cooks/constants.dart';
import 'package:monday_cooks/classes/user_data_class.dart';
import 'package:monday_cooks/database.dart';
import 'package:monday_cooks/classes/recipe_class.dart';
import 'package:monday_cooks/screens/recipe_page.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _auth = FirebaseAuth.instance;
  List<UserData> user = [UserData(userName: 'Test', userID: '')];
  List<Recipe> recipes = [
    Recipe(
        'Burger',
        'images/default_recipe.jpeg',
        5.5,
        25,
        'Main Dish',
        'Recipe Text here',
        '1999-01-01 00:01:00.000000',
        ['Tomato', 'Meat', 'Bread'],
        '5mjTOzKjEfeYSk9Fz3NV030WpTo2',
        '',
        '')
  ];
  List<Recipe> userRecipes = [
    Recipe(
        'Burger',
        'images/default_recipe.jpeg',
        5.5,
        25,
        'Main Dish',
        'Recipe Text here',
        '1999-01-01 00:01:00.000000',
        ['Tomato', 'Meat', 'Bread'],
        '5mjTOzKjEfeYSk9Fz3NV030WpTo2',
        '',
        '')
  ];
  List<Recipe> favoriteRecipes = [
    Recipe(
        'Burger',
        'images/default_recipe.jpeg',
        5.5,
        25,
        'Main Dish',
        'Recipe Text here',
        '1999-01-01 00:01:00.000000',
        ['Tomato', 'Meat', 'Bread'],
        '5mjTOzKjEfeYSk9Fz3NV030WpTo2',
        '',
        '')
  ];

  @override
  void initState() {
    super.initState();
    DataBaseService().getCurrentUser().then((userFromServer) {
      setState(() {
        user = userFromServer;
      });
    });
    DataBaseService().getRecipes().then((recipesFromServer) {
      setState(() {
        recipes = recipesFromServer;
        userRecipes = recipes
            .where((r) => r.userID.contains(_auth.currentUser.uid))
            .toList();
        favoriteRecipes = recipes
            .where((r) => r.favorite.contains(_auth.currentUser.uid))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 15.0),
                child: Text(
                  'Your Recipes, ${user[0].userName} ', //
                  style: kWelcomeTextField.copyWith(fontSize: 22),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.orangeAccent,
                ),
                child: Icon(FontAwesomeIcons.signOutAlt),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushNamed(context, '/tabsPage');
                },
              )
            ]),
            Container(
              height: 150,
              child: userRecipes.length == 0
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: kColorContainer,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text('Nothing here yet',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: (recipes != null) ? userRecipes.length : 1,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipePage(
                                          recipe: userRecipes[index])));
                            },
                            child: Container(
                              width: 200,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: FutureBuilderImages(
                                          userRecipes[index].recipeURL))),
                            ),
                       );
                  }),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15.0),
                    child: Text(
                      'Your Favorites',
                      style: kWelcomeTextField.copyWith(fontSize: 22),
                    ),
                  ),
                  Expanded(
                    child: favoriteRecipes.length == 0
                        ? Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 250,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xFF363636),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text('Nothing here yet',
                      style: TextStyle(
                        fontSize: 20
                      ),)),
                    )
                    : ListView.builder(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipePage(
                                          recipe: favoriteRecipes[index])));
                            },
                          );
                        }),
                  )
                ],
              ),
            ),
          ])
        ] //
            ),
      ),
    );
  }
}
