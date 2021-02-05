import 'package:flutter/material.dart';

class Recipe {

  final String recipeName;
  final String recipeURL;
  // final double recipeScore;
  // final int cookTime ;
  final String category;
  final String recipeText;
  ///TODO: Firebase loads "number"


  Recipe(this.recipeName, this.recipeURL, this.category, this.recipeText); //, this.cookTime, this.recipeScore

}