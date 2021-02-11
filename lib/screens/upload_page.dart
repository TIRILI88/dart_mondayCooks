import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monday_cooks/components/dialog_box.dart';
import 'package:monday_cooks/database.dart';
import 'dart:io';


class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  final _auth = FirebaseAuth.instance;
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
  final ingredientTextController = TextEditingController();
  final cookTimeTextController = TextEditingController();
  final scoreTextController = TextEditingController();
  final recipeTextTextController = TextEditingController();
  String category;
  int cookTime;
  double recipeScore;
  String recipeName;
  String imageURL;
  String ingredients;
  String recipeText;
  String dropdownValue = 'Category';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 120),
                      // Category Dropdown
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          isDense: true,
                          value: dropdownValue,
                          icon: Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.orangeAccent
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['Category', 'Main Dish', 'Dessert', 'Appetizer', 'Salad']
                              .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value));
                            }).toList(),
                        ),
                      ),
                      // Row: Cooking Time + Score
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: cookTimeTextController,
                                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                                textAlign: TextAlign.center,
                                decoration: kTextFieldDecoration.copyWith(hintText: 'Cooking Time'),
                                onChanged: (cookTimeValue) {
                                  cookTime = int.parse(cookTimeValue);
                                },
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Flexible(
                              child: TextField(
                                controller: scoreTextController,
                                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                                textAlign: TextAlign.center,
                                decoration: kTextFieldDecoration.copyWith(hintText: 'Your Score'),
                                onChanged: (scoreValue) {
                                  recipeScore = double.parse(scoreValue);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Recipe Name Text
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
                      // Ingredients Text
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

                      // Recipe Step Text
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orangeAccent),
                                borderRadius: BorderRadius.all(Radius.circular(32.0))
                            ),
                            height: 200.0,
                            child: TextField(
                              maxLines: 10,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: 'Recipe Steps',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              ),
                              onChanged: (recipeTextValue) {
                                recipeText = recipeTextValue;
                              },
                            ),
                          ),
                      ),

                      //Row camera Buttons
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
                      // Upload Button
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: kElevatedButtonStyle,
                          child: Text('Upload'),
                            onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              if (_auth.currentUser != null) {
                                await DataBaseService().uploadRecipe(dropdownValue, recipeName, ingredients, _image,
                                    cookTime, recipeScore, recipeText);
                              }
                            }
                             catch (e) {
                              DialogAlert(message: e.toString());
                            }

                            categoryTextController.clear();
                            recipeTextController.clear();
                            ingredientTextController.clear();
                            scoreTextController.clear();
                            cookTimeTextController.clear();
                            // recipeTextController.clear();
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
        ),
      ),
    );
  }
}
