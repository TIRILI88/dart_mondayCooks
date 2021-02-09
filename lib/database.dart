import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:monday_cooks/classes/category_class.dart';
import 'package:monday_cooks/classes/recipe_class.dart';
import 'classes/default_data.dart';
import 'classes/user_data_class.dart';


class DataBaseService {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String currentUser;

  Future<void> userName(userName) async {
    final CollectionReference user = _firestore.collection('users');
    final uid = await _auth.currentUser.uid;
    DocumentReference userDataRef = await user.add({
      'userName': userName,
      'userID': uid,
    });
    print('Doc Id from userName Func: ${userDataRef.id}');
    DefaultData.documentId = userDataRef.id;
    DefaultData.userName = userName;
    UserData(userName, uid);
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
    final CollectionReference recipesCollection = _firestore.collection('recipes');
    final uid = _auth.currentUser.uid;
    final imageURL = await uploadImage(image);
    final dateAdded = (DateTime.now()).toString();
    print('CurrentUser: $currentUser');

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
      'addingUser': currentUser,
    });
  }


  Future<List<Recipe>> getRecipes() async {
    final recipesData = await _firestore.collection('recipes').get();
    List<Recipe> recipes = [];
    for(var recipe in recipesData.docs) {
      Recipe recipeObj = Recipe(recipe['recipeName'], recipe['imageURL'], recipe['recipeScore'].toDouble(), recipe['cookTime'].toInt(),
          recipe['category'], recipe['recipeText'], recipe['dateAdded'], recipe['ingredients']); //,
      recipes.add(recipeObj);
    }
    recipes.sort((a, b) {return b.dateAdded.compareTo(a.dateAdded);});
    return recipes;
  }


  Future<List<Category>> getCategories() async {
    final categoryData = await _firestore.collection('categories').get();
    List<Category> categoriesList = [];
    for(var category in categoryData.docs) {
      Category categoryObj = Category(category['category']);
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
         UserData userObj = UserData(user['userName'], user['userID']);
         userDataList.add(userObj);
       }
     } else {
       userDataList.add(UserData('There', 'XXXXXXXXXX'));
     }
     return userDataList;
    }
}


class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child('images').child(image).getDownloadURL();
  }
}

