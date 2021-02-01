import 'package:flutter/material.dart';


class FoodScrollContainer extends StatelessWidget {
  FoodScrollContainer({@required this.recipeName, @required this.scoreNumber, @required this.cookingTime, @required this.imagePath});

  final String recipeName;
  final double scoreNumber;
  final int cookingTime;
  final String imagePath;

  @override
  Widget build(BuildContext context) {

    void _onTapNavigation() {
      Navigator.of(context).pushNamed('/recipePage');
          // recipeTitle: recipeName,
          // recipeImagePath: imagePath,
          // recipeDuration: cookingTime);
    }

    return Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(recipeName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 15),
                    Center(
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('👌',
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
              onTap: _onTapNavigation,
              child: Hero(
                  tag: 'recipeImage',
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,//200,
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: AssetImage(imagePath)),
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
            )
          ],
        )
    );
  }
}


