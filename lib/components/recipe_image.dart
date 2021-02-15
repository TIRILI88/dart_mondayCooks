import 'package:flutter/material.dart';
import '../database.dart';

class RecipeImageWidget extends StatelessWidget {
  RecipeImageWidget({@required this.imageName});
  
  final String imageName;
  
  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.vertical,
        children: [
          FutureBuilder(
            future: DataBaseService().getImage(context, imageName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.66,
                      child: snapshot.data,
                    ),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 0.8,
                    height: MediaQuery.of(context).size.width * 0.33,
                    child: CircularProgressIndicator(
                    ),
                  ),
                );
              }
              return Container(
                child: Text('ERROR',
                  style: TextStyle(
                      color: Colors.white
                  ),),
              );
            },
          ),
        ]);
  }
}
