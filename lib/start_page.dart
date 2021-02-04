// import 'SEARCH-BAR';
import 'package:flutter/material.dart';
import 'package:monday_cooks/default_data.dart';
import 'package:monday_cooks/recipe_page.dart';
import 'database.dart';
import 'dish_container.dart';
import 'scroll_container.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}


class _StartPageState extends State<StartPage> {

  final recipes = FirebaseFirestore.instance.collection('recipes').get();

  User loggedInUser;
  String documentId;
  String userName = 'There';

  @override
  Widget build(BuildContext context) {
  setState(() {
    userName = DefaultData.userName;
  });
    return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children:[
            Column(
              children: [
                // User Container
                Container(
                  height: 200,
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      // GetUserName(),

                      //// *****
                      Text('Hi $userName,',
                        style: kWelcomeTextField
                      ),
                      Text('I hope you are in the mood to cook!',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold
                        ),),
                      SizedBox(height: 20),
                      Divider(
                          color: kColorContainer
                      )
                    ],
                  ),
                ),
                //New Dishes Container
                Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'New dishes',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '42',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 20
                          ),)
                      ]
                  ),
                ),
                // Dish Category Slider
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                    Row(
                      children: [
                        DishContainer(dish: 'Main Dishes'),
                        DishContainer(dish: 'Desserts'),
                        DishContainer(dish: 'Fish'),
                        DishContainer(dish: 'Pasta')
                      ]
                ),
                ),
                SizedBox(height: 20),
                // *** SEARCHBAR FOR LATER USE
                // SearchBar(onSearch: onSearch, onItemFound: onItemFound),
                // Recipe Container Slider
                Expanded(child:
                    FutureBuilder(
                      future: DataBaseService().getRecipes(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Text('Loading ....',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,)
                          ));
                        } else {
                        return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index){
                          return FoodScrollContainer(
                            recipeName: snapshot.data[index].recipeName,
                            scoreNumber: 4.63,
                            cookingTime: 45,
                            imagePath: snapshot.data[index].recipeURL,
                            onTapNavigation: () {
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RecipePage(recipe: snapshot.data[index])));
                            },
                          );
                          });
                        }
                      },
                    )


                        ),
                ],
            ),
        ]),
        );
  }
}

