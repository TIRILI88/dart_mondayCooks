import 'package:flutter/material.dart';


class DishContainer extends StatelessWidget {
  DishContainer({this.category, this.onTap});

  final String category;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0xFF363636),
            borderRadius: BorderRadius.circular(10)
        ),
        child:
        Row(
          children: [
            Text(
                category,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(width: 15),
            Icon(
              Icons.close,
              color: Colors.orangeAccent,
            )
          ],
        ),
      ),
    );
  }
}

