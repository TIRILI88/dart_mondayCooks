import 'package:flutter/material.dart';


class DishContainer extends StatelessWidget {
  DishContainer({@required this.dish});

  final String dish;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              dish,
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
    );
  }
}

