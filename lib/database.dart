import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class DataBaseService {
  DataBaseService({this.uid});

  final String uid;
  final CollectionReference recipesCollection = FirebaseFirestore.instance.collection('recipes');

  Future updateData(String category,String recipeName, String imageName, String ingredients) async {

    return await recipesCollection.doc(uid).set({
      'category': category,
      'recipeName': recipeName,
      'imageName': imageName,
      'ingredients': ingredients
    });
  }
}