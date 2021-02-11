import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/constants.dart';
import '../classes/default_data.dart';
import 'package:monday_cooks/classes/user_data_class.dart';
import 'package:monday_cooks/database.dart';
import 'package:monday_cooks/classes/recipe_class.dart';


class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  final _auth = FirebaseAuth.instance;
  List<UserData> user;
  List<Recipe> recipes;
  List<Recipe> userRecipes;


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
                SizedBox(height: 100),
                Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: (recipes != null) ? userRecipes.length : 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
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
                          );
                        }
                ),
                ),
                Container(
                  child: Text('Your Favorites',
                  textAlign: TextAlign.left,
                  style: kWelcomeTextField.copyWith(fontSize: 22),),
                ),

              ]),
            )
          ] //
        ),
      ),
    );
  }
}
