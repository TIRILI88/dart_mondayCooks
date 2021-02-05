import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:monday_cooks/constants.dart';
import 'recipe_class.dart';
import 'default_data.dart';

String userDocumentID;

class DataBaseService {

  final _auth = FirebaseAuth.instance;

  Future<void> userName(userName) async {
    final CollectionReference user = FirebaseFirestore.instance.collection('users');
    final uid = await _auth.currentUser.uid;
    DocumentReference userDataRef = await user.add({
      'userName': userName,
      'userID': uid,
    });
    print('Doc Id from userName Func: ${userDataRef.id}');
    DefaultData.documentId = userDataRef.id;
    DefaultData.userName = userName;
    getUserIDQuery();
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
    // final downloadURL = await FirebaseStorage.instance.ref().child('images').child(fileName).getDownloadURL();

    return fileName; //downloadURL;
  }

  Future uploadRecipe(String category, String recipeName, String ingredients,
      image, int cookTime, double recipeScore, String recipeText) async {
    final CollectionReference recipesCollection = FirebaseFirestore.instance
        .collection('recipes');
    final uid = await _auth.currentUser.uid;
    final imageURL = await uploadImage(image);

    return await recipesCollection.add({
      'userID': uid,
      'category': category,
      'recipeName': recipeName,
      'imageURL': imageURL,
      'ingredients': ingredients,
      'cookTime': cookTime,
      'recipeScore': recipeScore,
      'recipeText': recipeText
    });
  }

  Future<List<Recipe>> getRecipes() async {
    print('getRecipes() started');

    final recipesData = await FirebaseFirestore.instance.collection('recipes').get();
    List<Recipe> recipes = [];
    for(var recipe in recipesData.docs) {
      Recipe recipeObj = Recipe(recipe['recipeName'], recipe['imageURL'], recipe['category'], recipe['recipeText']); //, recipe['cookTime'], recipe['recipeScore'],
      recipes.add(recipeObj);
    }
    print(recipes.length);
    return recipes;
  }


  getUserIDQuery() {
    final userId = FirebaseFirestore.instance
        .collection('users')
        .where('userID', isEqualTo: _auth.currentUser.uid)
        .get();
    print(userId);
  }
}


class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child('images').child(image).getDownloadURL();
  }
}

class GetUserName extends StatelessWidget {
  GetUserName({@required this.documentId});

  final String documentId;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final _auth = FirebaseAuth.instance;
    print('DocID from GetUserNameClass $documentId');

      if (_auth.currentUser != null && documentId != null) {
        return FutureBuilder<DocumentSnapshot>(
          future: users.doc(documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              print(data['userName']);
              return Text("Hi ${data['userName']},",
                  style: kWelcomeTextField);
            }

            return Text("loading");
          },
        );
      } else {
        return Text('Hi There',
          style: kWelcomeTextField,
        );
      }
  }
}
