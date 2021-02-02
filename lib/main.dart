import 'package:flutter/material.dart';
import 'package:monday_cooks/recipe_page.dart';
import 'package:monday_cooks/start_page.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MondayCooks());
}

class MondayCooks extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF212121),
        scaffoldBackgroundColor: Color(0xFF212121),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => StartPage(),
        '/recipePage': (context) => RecipePage(
            recipeTitle: 'recipeTitle',
            recipeImagePath: 'images/default_recipe.jpeg',
            recipeDuration: 0),
      },
      // onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}


