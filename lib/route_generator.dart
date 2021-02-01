// import 'package:flutter/material.dart';
// import 'main.dart';
// import 'start_page.dart';
// import 'recipe_page.dart';
//
//
// class RouteGenerator {
//   static Route generateRoute(RouteSettings settings) {
//     final args = settings.arguments;
//
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (_) => StartPage());
//       case '/recipePage':
//         return MaterialPageRoute(builder: (_) => RecipePage(
//           args
//         ));
//       default:
//         return _errorRoute();
//     }
//   }
//
//   static Route _errorRoute() {
//     return MaterialPageRoute(builder: (_) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Error'),
//         ),
//         body: Center(
//           child: Text('ERROR'),
//         ),
//       );
//     });
//   }
//
// }