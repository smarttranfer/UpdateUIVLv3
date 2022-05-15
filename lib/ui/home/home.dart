import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/theme/Color_app.dart';

import '../customelist/customelist.dart';

class Home_page extends StatefulWidget {
  @override
  _Home_page createState() => _Home_page();
}

class _Home_page extends State<Home_page> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();


  Future _getDataCutomer() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.people_alt_sharp, size: 30,color: App_Color.green,),
            Icon(Icons.person, size: 30,color: App_Color.green),
            Icon(Icons.stacked_bar_chart, size: 30,color: App_Color.green),
            Icon(Icons.settings, size: 30,color: App_Color.green),
          ],
          color: App_Color.background_textfield,
          buttonBackgroundColor: App_Color.background_textfield,
          backgroundColor: App_Color.Background,
          animationCurve: Curves.easeInOutCubicEmphasized,
          animationDuration: Duration(milliseconds: 500),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: App_Color.Background,
          child: Center(
            child: Customelist()
          ),
        ));
  }
}