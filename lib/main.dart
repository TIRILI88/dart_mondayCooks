import 'package:flutter/material.dart';
import 'start_page.dart';
import 'recipe_page.dart';
import 'tabs_page.dart';
import 'user_login.dart';
import 'constants.dart';
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
        primaryColor: kColorBackgroundDark,
        scaffoldBackgroundColor: kColorBackgroundDark,
      ),
      home: TabsPage(),
      routes: {
        '/recipePage': (context) => RecipePage(
            recipeTitle: 'recipeTitle',
            recipeImagePath: 'images/default_recipe.jpeg',
            recipeDuration: 0),
        '/startPage': (context) => StartPage(),
        '/tabsPage' :(context) => TabsPage(),
        '/userLogin': (context) => UserLogin(),
      },
      // onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}


