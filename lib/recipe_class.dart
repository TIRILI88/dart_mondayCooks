import 'package:flutter/material.dart';

class Recipe {

  final String recipeTitle;
  final String recipeImagePath;
  final int recipeCookingTime;
  final double recipeScoreNumber;

  Recipe({@required this.recipeTitle, @required this.recipeImagePath, @required this.recipeCookingTime, @required this.recipeScoreNumber});

}