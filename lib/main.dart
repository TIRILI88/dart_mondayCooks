import 'package:flutter/material.dart';
import 'package:monday_cooks/screens/start_page.dart';
import 'navigation/tabs_page.dart';
import 'screens/user_login.dart';
import 'constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MondayCooks());
}

class MondayCooks extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: kColorBackgroundDark,
        scaffoldBackgroundColor: kColorBackgroundDark,
        indicatorColor: Colors.orangeAccent,
        accentColor: Colors.orangeAccent,
      ),
      home: TabsPage(),
      routes: {
        '/startPage': (context) => StartPage(),
        '/tabsPage' :(context) => TabsPage(),
        '/userLogin': (context) => UserLogin(),
      },
      // onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}


