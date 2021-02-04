import 'package:flutter/material.dart';

class Recipe {

  final String recipeName;
  final String recipeURL;
  final double recipeScore = 4.63;
  final int recipeTime = 45;

  Recipe(this.recipeName, this.recipeURL);

}