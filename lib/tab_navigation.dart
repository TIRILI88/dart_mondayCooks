import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monday_cooks/favorites_page.dart';
import 'package:monday_cooks/search_page.dart';
import 'package:monday_cooks/start_page.dart';
import 'package:monday_cooks/upload_page.dart';
import 'package:monday_cooks/user_page.dart';


class TabNavigationItem {
  final Widget page;
  final String title;
  final Widget icon;

  TabNavigationItem(
      {@required this.page, @required this.title, @required this.icon});

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
        page: StartPage(),
        title: 'Home',
        icon: Icon(FontAwesomeIcons.home)),
    TabNavigationItem(
        page: SearchPage(),
        title: 'Search',
        icon: Icon(FontAwesomeIcons.search)),
    TabNavigationItem(
        page: UploadPage(),
        title: 'Add Recipe',
        icon: Icon(FontAwesomeIcons.plusCircle)),
    TabNavigationItem(
        page: FavoritesPage(),
        title: 'Favorites',
        icon: Icon(FontAwesomeIcons.star)),
    TabNavigationItem(
        page: UserPage(),
        title: 'Me',
        icon: Icon(FontAwesomeIcons.userCircle)),
  ];

}