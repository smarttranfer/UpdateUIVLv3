import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/theme/Color_app.dart';

import '../customelist/customelist.dart';
import '../develop/develop.dart';
import '../setting/setting.dart';

class Home_page extends StatefulWidget {
  @override
  _Home_page createState() => _Home_page();
}

class _Home_page extends State<Home_page> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabItems = <Widget>[
      Customelist(),
      Develop(),
      Develop(),
      SettingsPage()
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: App_Color.background_textfield,
          selectedIndex: currentIndex,
          onItemSelected: (index){
            setState(() {
              currentIndex = index;
            });
          }, items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text(""),
            activeColor: App_Color.green,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people_alt_rounded),
            title: Text(''),
            activeColor: App_Color.green,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.bar_chart,),
            title: Text(''),
            activeColor: App_Color.green,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text(''),
            activeColor: App_Color.green,
            inactiveColor: App_Color.green,
          ),
        ]),
        body: Container(
          color: App_Color.Background,
          child: Center(child: tabItems[currentIndex]),
        ));
  }
}
