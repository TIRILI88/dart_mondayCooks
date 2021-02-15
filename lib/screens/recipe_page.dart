import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/constants.dart';
import 'package:monday_cooks/components/recipe_image.dart';
import 'package:monday_cooks/database.dart';
import 'package:monday_cooks/navigation/tab_navigation.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:monday_cooks/components/tab_widget.dart';
import 'package:monday_cooks/classes/recipe_class.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RecipePage extends StatelessWidget {
  RecipePage({this.recipe});
  
  final _auth = FirebaseAuth.instance;
  final Recipe recipe;
  final double tabBarHeight = 80;
  final panelController = PanelController();
  List<String> ingredientsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.recipeName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.star),
            highlightColor: Colors.orangeAccent,
            tooltip: 'Add to your favorites',
            onPressed: () {
              print('IconButton pressed');
              // DataBaseService().addToFavorites(recipe.docID, _auth.currentUser.uid);
            },
          )
        ],
      ),
      body: Column(
        children: [
          SlidingUpPanel(
            controller: panelController,
            color: kColorContainer,
            minHeight: MediaQuery.of(context).size.height * 0.3,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            panelBuilder: (scrollController) => buildSlidingPanel(
              scrollController: scrollController,
              panelController: panelController,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(child: RecipeImageWidget(imageName: recipe.recipeURL)),
                  Text('Added from: ${recipe.userID}')
                ],
              ),
            ),


          ),
        ],
      ),
    );
  }

  Widget buildSlidingPanel({
  @required PanelController panelController, @required ScrollController scrollController,
}) =>
      DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: buildTabBar(
              onClicked: panelController.open, //
            ),
            body: TabBarView(
              children: [
                TabWidget(scrollController: scrollController, textValue: recipe.recipeText),
                // TabWidget(scrollController: scrollController, textValue: recipe.ingredients),
              ],
            ),
          ));

 Widget buildTabBar({
  @required VoidCallback onClicked,
}) => PreferredSize(
     preferredSize: Size.fromHeight(tabBarHeight - 8),
      child: GestureDetector(
        onTap: onClicked,
        child: AppBar(
          title: Icon(Icons.drag_handle),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Recipe')),
              Tab(child: Text('Ingredients'))
            ],
          ),
        ),
      ),
 );
}
