// import 'SEARCH-BAR';
import 'package:flutter/material.dart';
import 'package:monday_cooks/recipe_class.dart';
import 'package:monday_cooks/recipe_page.dart';
import 'database.dart';
import 'dish_container.dart';
import 'scroll_container.dart';
import 'constants.dart';
import 'category_class.dart';
import 'user_data.dart';


class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  List<Recipe> recipes;
  List<Recipe> filteredRecipes;
  List<Category> categories;
  List<UserData> user;

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
                  height: 200,
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                          future: DataBaseService().getCurrentUser(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Text('Hi There!',
                              style: kWelcomeTextField);
                            } else {
                              return Text('Hi ${snapshot.data[0].userName}',
                              style: kWelcomeTextField);
                           }
                        }
                      ),
                      Text('I hope you are in the mood to cook!',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold
                        ),),
                      SizedBox(height: 20),
                      Divider(
                          color: Colors.grey
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
                  height: 100,
                  child: Expanded(
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
                ),
                SizedBox(height: 20),
                // *** SEARCHBAR FOR LATER USE
                // SearchBar(onSearch: onSearch, onItemFound: onItemFound),
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

