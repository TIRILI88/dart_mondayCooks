import 'package:flutter/material.dart';
import 'package:monday_cooks/components/future_builder_images.dart';
import 'package:monday_cooks/database.dart';
import '../database.dart';

class FoodScrollContainer extends StatelessWidget {
  FoodScrollContainer(
      {this.recipeName, this.scoreNumber, this.cookingTime, this.imagePath, this.onTapNavigation});

  final String recipeName;
  final double scoreNumber;
  final int cookingTime;
  final String imagePath;
  final Function onTapNavigation;

  String scoreEmoji(double score) {
    if (score > 5) {
      return '👌';
  } else {
      return '👇';
  }
}

  @override
  Widget build(BuildContext context) {

    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 250,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0xFF363636),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Left Side Text
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  width: 150,
                  child:
                  //Recipe Name
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(recipeName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),),
                        SizedBox(height: 15),
                        //Recipe Score
                        Center(
                          child:
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(scoreEmoji(scoreNumber),
                                    style: TextStyle(
                                        fontSize: 25
                                    )),
                                SizedBox(width: 10),
                                Text(scoreNumber.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orangeAccent))
                              ]),
                        ),
                        SizedBox(height: 15),
                        // CookTime Container
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('${cookingTime.toString()} MIN',
                              style: TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              )),
                        )
                      ])),
              //Right Side Picture
              GestureDetector(
                onTap: onTapNavigation,
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4, //200,
                    height: 280,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FutureBuilderImages(imagePath)
                    ),
                  ),
                ),
              )
            ]
        ));
  }
}


