import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'database.dart';
import 'constants.dart';
import 'dart:io';


class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  File _image;
  final picker = ImagePicker();

  Future cameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future galleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }




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
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Ingredients'),
                    onChanged: (value) {
                      ingredients = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: kElevatedButtonStyle,
                        child: Icon(FontAwesomeIcons.images,
                        size: 40,),
                        onPressed: (){
                          galleryImage();
                        }),
                      ElevatedButton(
                        style: kElevatedButtonStyle,
                          child: Icon(FontAwesomeIcons.cameraRetro),
                          onPressed: (){
                            cameraImage();
                          }),
                  ]),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: kElevatedButtonStyle,
                    child: Text('Upload'),
                      onPressed: (){
                      DataBaseService().uploadImage(context, _image);
                      DataBaseService().uploadRecipe(category, recipeName, ingredients);
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
