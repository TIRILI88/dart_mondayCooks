import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DataBaseService {

  String imageURL;

  Future<String> getUserUID() async {
    final _auth = FirebaseAuth.instance;
    final uid = await _auth.currentUser.uid;

    return uid;
  }

  Future<void> userName(userName) async {
    final CollectionReference user = FirebaseFirestore.instance.collection('users');
    return await user.add({
      'userName': userName,
      'userID' : getUserUID(),
    });
  }

  Future<Widget> getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((downloadUrl) {
      image = Image.network(downloadUrl, fit: BoxFit.cover);
    });
    return image;
  }

  Future<void> uploadImage(BuildContext context, image) async {
    String fileName = (image.path);

    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('images').child(fileName);
    final uploadTask = firebaseStorageRef.putFile(image);
    final downloadURL = await uploadTask.snapshot.ref.getDownloadURL();
    imageURL = downloadURL;

    return;
  }

  Future uploadRecipe(String category,String recipeName, String ingredients) async {
    final CollectionReference recipesCollection = FirebaseFirestore.instance.collection('recipes');
    return await recipesCollection.add({
      'userID': getUserUID(),
      'category': category,
      'recipeName': recipeName,
      'imageURL': imageURL,
      'ingredients': ingredients,
    });
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  // StorageReference photosReference = ;

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child('images').child(image).getDownloadURL();
  }
}