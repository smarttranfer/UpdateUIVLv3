import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/theme/Color_app.dart';

import '../customelist/customelist.dart';
import '../setting/setting.dart';

class Home_page extends StatefulWidget {
  @override
  _Home_page createState() => _Home_page();
}

class _Home_page extends State<Home_page> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabItems = [Customelist(), Customelist(), SettingsPage(),SettingsPage()];
    Widget page  = _tabItems[3];
    int activePage = 0;
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.people_alt_outlined, size: 30,color: App_Color.green,),
            Icon(Icons.person_outline_outlined, size: 30,color: App_Color.green),
            Icon(Icons.bar_chart_outlined, size: 30,color: App_Color.green),
            Icon(Icons.settings_outlined, size: 30,color: App_Color.green),
          ],
          color: App_Color.background_textfield,
          buttonBackgroundColor: App_Color.background_textfield,
          backgroundColor: App_Color.Background,
          animationCurve: Curves.easeInOutCubicEmphasized,
          animationDuration: Duration(milliseconds: 500),
          onTap: (index) {
            setState(() {
              activePage = index;
              page = _tabItems[activePage];
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: App_Color.Background,
          child: Center(
            child: page
          ),
        ));
  }
}