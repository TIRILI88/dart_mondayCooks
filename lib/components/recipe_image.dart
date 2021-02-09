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
                return Center(
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    child: snapshot.data,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: MediaQuery.of(context).size.width / 0.8,
                  height: MediaQuery.of(context).size.width / 0.8,
                  child: CircularProgressIndicator(
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
