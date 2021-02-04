import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DataBaseService {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> userName(userName) async {
    final CollectionReference user = FirebaseFirestore.instance.collection('users');
    final uid = await _auth.currentUser.uid;
    return await user.add({
      'userName': userName,
      'userID' : uid,
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

    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('images/$fileName');
    firebaseStorageRef.putFile(image);
    // final downloadURL = await FirebaseStorage.instance.ref().child('images').child(fileName).getDownloadURL();

    return fileName; //downloadURL;
  }

  Future uploadRecipe(String category,String recipeName, String ingredients, image) async {
    final CollectionReference recipesCollection = FirebaseFirestore.instance.collection('recipes');
    final uid = await _auth.currentUser.uid;
    final imageURL = await uploadImage(image);

    return await recipesCollection.add({
      'userID': uid,
      'category': category,
      'recipeName': recipeName,
      'imageURL': imageURL,
      'ingredients': ingredients,
    });
  }

  Future<String> getName() async {
    if (_auth.currentUser != null) {
      final userData = await _firestore.collection('users').get();
      for (var user in userData.docs) {
        final lowerCaseName = user.data()['userName'].toLowerCase();
        final name = lowerCaseName[0].toUpperCase() + lowerCaseName.substring(1);
        print(name);
        return 'Hi ${name}';
      }
    } else {
      return 'Hi There';
    }
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child('images').child(image).getDownloadURL();
  }
}