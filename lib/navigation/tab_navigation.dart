import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/screens/start_page.dart';
import 'package:monday_cooks/screens/upload_page.dart';
import 'package:monday_cooks/screens/user_login.dart';
import 'package:monday_cooks/screens/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'globals.dart' as globals;

User user;
bool isLoggedIn = false;

class TabNavigationItem {
  final Widget page;
  final String title;
  final Widget icon;


  static Widget isUserLoggedIn() {
    try {
      final User user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        isLoggedIn = true;
        return UserPage();
      } else {
        return UserLogin();
      }
    }
    catch (e) {
      print(e);
    }
  }


  TabNavigationItem(
      {@required this.page, @required this.title, @required this.icon});

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
        page: StartPage(), //TestStartPage()
        title: 'Home',
        icon: Icon(FontAwesomeIcons.home)),
    TabNavigationItem(
        page: UploadPage(),
        title: 'Add Recipe',
        icon: Icon(FontAwesomeIcons.plusCircle)),
    TabNavigationItem(
        page: isUserLoggedIn(),
        title: 'Me',
        icon: Icon(FontAwesomeIcons.userCircle)),
  ];

}