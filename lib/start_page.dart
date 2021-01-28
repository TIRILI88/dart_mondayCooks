import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dish_container.dart';
import 'scroll_container.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children:[
            Column(
              children: [
                Container(
                  height: 200,
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text('Hi Daniel',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('I hope you are in the mood to cook!',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
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
                Expanded(child:
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child:
                      Column(
                        children: [
                          FoodScrollContainer(
                            recipeName: 'Mexican Potatoes',
                            scoreNumber: 4.63,
                            cookingTime: 45,
                            imagePath: 'images/mexcian_potatoes.jpeg',
                          ),
                          FoodScrollContainer(
                              recipeName: 'Salmon',
                              scoreNumber: 5.8,
                              cookingTime: 20,
                              imagePath: 'images/salmon.jpeg'
                          ),
                          FoodScrollContainer(
                              recipeName: 'Pumpkin Soup',
                              scoreNumber: 3.61,
                              cookingTime: 35,
                              imagePath: 'images/pumpkin_soup.jpeg'
                          ),
                        ],
                      ),
                    )
                  //
                ),
              ],
            ),
        ]),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Color(0xFF212121)
          ),
          child: BottomNavigationBar(
            fixedColor: Colors.white,
            items: [
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home,
              color: Colors.white,),
              label: 'Home',
              ),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.lemon),
                  label: 'Recipes'
              ),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.pepperHot),
                  label: 'Pepper'
              ),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userCircle),
                  label: 'My Account'
              ),
            ],
          ),
        ));
  }

}

