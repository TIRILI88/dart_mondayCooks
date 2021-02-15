
class Recipe {

  final String recipeName;
  final String recipeURL;
  final double recipeScore;
  final int cookTime;
  final String category;
  final String recipeText;
  final String dateAdded;
  final List ingredients;
  final String userID;
  final String docID;
  final String favorite;

  Recipe(
    this.recipeName,
      this.recipeURL,
      this.recipeScore,
      this.cookTime,
      this.category,
      this.recipeText,
      this.dateAdded,
      this.ingredients,
      this.userID,
      this.docID,
      this.favorite);

}