import 'package:flutter/material.dart';
import 'package:monday_cooks/constants.dart';
import 'database.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  final messageTextController = TextEditingController();
  String category;
  String recipeName;
  String imageURL;
  String ingredients;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/default_recipe.jpeg'),
            fit: BoxFit.cover,
          )
        ),
          child: Container(
            decoration: BoxDecoration(
              color: kColorContainer.withOpacity(0.9)
            ),
            child: Column(
              children: [
                SizedBox(height: 300),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: messageTextController,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Category'),
                    onChanged: (value) {
                      category = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: messageTextController,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Recipe Name'),
                    onChanged: (value) {
                      recipeName = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: messageTextController,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Image URL - DUMMY'),
                    onChanged: (value) {
                      imageURL = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: messageTextController,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Ingredients'),
                    onChanged: (value) {
                      ingredients = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text('Upload'),
                      onPressed: (){
                        DataBaseService().updateData(category, recipeName, imageURL, ingredients);
                        messageTextController.clear();
                      }),
                )
              ],
            ),
          ),
        ),
    );
  }
}
