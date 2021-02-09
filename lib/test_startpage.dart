import 'package:flutter/material.dart';
import 'package:monday_cooks/database.dart';
import 'package:monday_cooks/dish_container.dart';
import 'package:monday_cooks/recipe_class.dart';
import 'package:monday_cooks/category_class.dart';
import 'package:monday_cooks/scroll_container.dart';
import 'recipe_page.dart';
import 'user_data.dart';


class TestStartPage extends StatefulWidget {
  @override
  _TestStartPageState createState() => _TestStartPageState();
}

class _TestStartPageState extends State<TestStartPage> {

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
        alignment: Alignment.center,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Container(
                  child:
                    Text(
                    'Hi ${user[0].userName}'
                  )
                ),
                Expanded(
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
                SizedBox(height: 100,),

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
          Expanded(
            child: ListView.builder(
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
              ]
            ),
          ),

        ],
      ),
    );
  }
}
