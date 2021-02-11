import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/constants.dart';
import 'package:monday_cooks/components/recipe_image.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:monday_cooks/components/tab_widget.dart';
import 'package:monday_cooks/classes/recipe_class.dart';

class RecipePage extends StatelessWidget {
  RecipePage({this.recipe});
  
  final Recipe recipe;
  final double tabBarHeight = 80;
  final panelController = PanelController();
  List<String> ingredientsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.recipeName),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Icon(FontAwesomeIcons.star))
        ],
      ),
      body: SlidingUpPanel(
        controller: panelController,
        color: kColorContainer,
        minHeight: MediaQuery.of(context).size.height * 0.3,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        panelBuilder: (scrollController) => buildSlidingPanel(
          scrollController: scrollController,
          panelController: panelController,
        ),
        body: Center(child: RecipeImageWidget(imageName: recipe.recipeURL))
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
