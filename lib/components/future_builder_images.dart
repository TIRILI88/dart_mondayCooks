import 'package:flutter/material.dart';
import 'package:monday_cooks/database.dart';


class FutureBuilderImages extends StatelessWidget {
  FutureBuilderImages(this.imageName);

  final String imageName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DataBaseService().getImage(context, imageName),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 0.8,
              child: snapshot.data,
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            child: Text('Something went wrong',
            style: TextStyle(
              color: Colors.white
            ),)
          );
        }
      );
  }
}
