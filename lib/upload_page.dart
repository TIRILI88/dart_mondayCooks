import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'database.dart';
import 'constants.dart';
import 'dart:io';


class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  File _image;
  bool showSpinner = false;

  Future getImage(source) async {
    final pickedFile = await ImagePicker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  final categoryTextController = TextEditingController(); //..text = 'Main Dish';
  final recipeTextController = TextEditingController(); //..text = 'Tomatoes';
  final ingredientTextController = TextEditingController(); //..text = 'Tomatoes, Garlic, Oil';
  String category;
  String recipeName;
  String imageURL;
  String ingredients;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
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
                      controller: categoryTextController,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Category'),
                      onChanged: (categoryValue) {
                        category = categoryValue;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: recipeTextController,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Recipe Name'),
                      onChanged: (recipeValue) {
                        recipeName = recipeValue;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: ingredientTextController,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Ingredients'),
                      onChanged: (ingredientValue) {
                        ingredients = ingredientValue;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Gallery Button
                        ElevatedButton(
                          style: kElevatedButtonStyle,
                          child: Icon(FontAwesomeIcons.images,
                          size: 40,),
                          onPressed: (){
                            getImage(ImageSource.gallery);
                          }),
                        // Camera Button
                        ElevatedButton(
                          style: kElevatedButtonStyle,
                            child: Icon(FontAwesomeIcons.cameraRetro),
                            onPressed: (){
                              getImage(ImageSource.gallery);
                            }),
                    ]),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: kElevatedButtonStyle,
                      child: Text('Upload'),
                        onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        await DataBaseService().uploadRecipe(category, recipeName, ingredients, _image);
                        // categoryTextController.clear();
                        // recipeTextController.clear();
                        // ingredientTextController.clear();
                        setState(() {
                          showSpinner = false;
                        });
                        }),
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}
