import 'package:flutter/material.dart';


class DishContainer extends StatelessWidget {
  DishContainer({this.category, this.onTap, this.isActive});

  final String category;
  final Function onTap;
  final bool isActive;
  Color isActiveColor = Color(0xFF363636);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isActiveColor,//isActive ? Colors.orangeAccent : Color(0xFF363636),
            borderRadius: BorderRadius.circular(10)
        ),
        child:
        Center(
          child: Text(
              category,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}

