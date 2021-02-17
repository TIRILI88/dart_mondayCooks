import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/screens/start_page.dart';
import 'package:monday_cooks/screens/upload_page.dart';
import 'package:monday_cooks/screens/user_login.dart';
import 'package:monday_cooks/screens/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


User user;
bool isLoggedIn = false;

class TabNavigationItem {
  final Widget page;
  final String title;
  final Widget icon;


  TabNavigationItem(
      {@required this.page, @required this.title, @required this.icon});

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
        page: StartPage(), //TestStartPage()
        title: 'Home',
        icon: Icon(FontAwesomeIcons.home)),
    TabNavigationItem(
        page: (FirebaseAuth.instance.currentUser != null) ? UploadPage(): UserLogin(),
        title: 'Add Recipe',
        icon: Icon(FontAwesomeIcons.plusCircle)),
    TabNavigationItem(
        page: (FirebaseAuth.instance.currentUser != null) ? UserPage() : UserLogin(),
        title: 'User',
        icon: Icon(FontAwesomeIcons.userCircle)),
  ];

}