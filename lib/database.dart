import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:monday_cooks/classes/category_class.dart';
import 'package:monday_cooks/classes/recipe_class.dart';
import 'classes/user_data_class.dart';


class DataBaseService {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  List<UserData> user;



  makeList(String stringList) {
    List<String> ingredientsList = [];
    for (var item in stringList.split(', ')) {
      ingredientsList.add(item.toString());
    }
    return ingredientsList;
  }

  Future<void> userName(userName) async {
    final CollectionReference user = _firestore.collection('users');
    final uid = await _auth.currentUser.uid;
    DocumentReference userDataRef = await user.add({
      'userName': userName,
      'userID': uid,
    });
  }

  Future<Widget> getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((downloadUrl) {
      image = Image.network(downloadUrl, fit: BoxFit.cover);
    });
    return image;
  }

  Future uploadImage(image) async {
    String fileName = (DateTime.now().toString());
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'images/$fileName');
    firebaseStorageRef.putFile(image);

    return fileName;
  }

  Future uploadRecipe(String category, String recipeName, String ingredients,
      image, int cookTime, double recipeScore, String recipeText) async {

    print('Recipe upload called');

    final CollectionReference recipesCollection = _firestore.collection('recipes');
    final uid = _auth.currentUser.uid;
    final imageURL = await uploadImage(image);
    final dateAdded = (DateTime.now()).toString();


    return await recipesCollection.add({
      'userID': uid,
      'category': 'All, $category',
      'recipeName': recipeName,
      'imageURL': imageURL,
      'ingredients': ingredients,
      'cookTime': cookTime,
      'recipeScore': recipeScore,
      'recipeText': recipeText,
      'dateAdded': dateAdded,
      'favorite' : '',
      // 'addingUser': user[0].userName, ///TODO Adding User
    });
  }


  Future<List<Recipe>> getRecipes() async {
    final recipesData = await _firestore.collection('recipes').get();
    List<Recipe> recipes = [];
    for(var recipe in recipesData.docs) {
      Recipe recipeObj = Recipe(recipe['recipeName'], recipe['imageURL'], recipe['recipeScore'].toDouble(), recipe['cookTime'].toInt(),
          recipe['category'], recipe['recipeText'], recipe['dateAdded'], makeList(recipe['ingredients']),
          recipe['userID'], recipe.id, recipe['favorite']); //,
      recipes.add(recipeObj);
    }
    recipes.sort((a, b) {return b.dateAdded.compareTo(a.dateAdded);});
    return recipes;
  }


  Future<List<Category>> getCategories() async {
    final categoryData = await _firestore.collection('categories').get();
    List<Category> categoriesList = [];
    for(var category in categoryData.docs) {
      Category categoryObj = Category(category['category'], false);
      categoriesList.add(categoryObj);
    }
    categoriesList.sort((a, b) {return a.category.compareTo(b.category);});
    return categoriesList;
  }

  Future<List<UserData>> getCurrentUser() async {
    List<UserData> userDataList = [];
    if (_auth.currentUser != null){
       final userId = await _firestore.collection('users')
           .where('userID', isEqualTo: _auth.currentUser.uid)
           .get();
       for (var user in userId.docs) {
         UserData userObj = UserData(userName: user['userName'], userID: user['userID']);
         userDataList.add(userObj);
       }
     } else {
       userDataList.add(UserData(userName: 'There',userID: 'XXXXXXXXXX'));
     }
     return userDataList;
  }

  getIngredientImage(fileName) {
    var syncPath = 'images/ingredient_icons/${fileName.toLowerCase()}.png';
    if (File(syncPath).exists() != null) {
      return syncPath;
    } else {
      return 'images/ingredient_icons/carrot.png';
    }
  }

  addToFavorites(document, userID) async {
    await _firestore.collection('recipes').doc(document).update({
      'favorite': userID,
    });
    getRecipes();
  }

  Future editRecipe(context, docID, category, recipeName, imageURL, ingredients, cookTime, recipeScore, recipeText) async {
    await _firestore.collection('recipes').doc(docID).update({
      'category': category,
      'recipeName': recipeName,
      'imageURL': imageURL,
      'ingredients': ingredients,
      'cookTime': cookTime,
      'recipeScore': recipeScore,
      'recipeText': recipeText,
    });
    getRecipes();
  }
}


class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child('images').child(image).getDownloadURL();
  }
}

