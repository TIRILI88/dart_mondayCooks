import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monday_cooks/navigation/tab_navigation.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0)
          )
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0)
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int index) => setState(() => _currentIndex = index),
            items : [
              for (final tabItem in TabNavigationItem.items)
                BottomNavigationBarItem(
                    icon: tabItem.icon,
                    label: tabItem.title
                ),
            ],
          selectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,),
        ),
      ),
      );
  }
}
