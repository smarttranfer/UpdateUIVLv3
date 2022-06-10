import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../customelist/customelist.dart';
import '../develop/develop.dart';
import '../setting/setting.dart';

class Home_page extends StatefulWidget {
  @override
  _Home_page createState() => _Home_page();
}

class _Home_page extends State<Home_page> {
  final _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabItems = <Widget>[
      Customelist(),
      Develop(Tilte: "Quản lý nhân sự"),
      Develop(Tilte: "Thống kê"),
      SettingsPage()
    ];
    return Scaffold(
        body: PageView(
          controller: _controller,
          children: <Widget>[
            Customelist(),
            Develop(Tilte: "Quản lý nhân sự"),
            Develop(Tilte: "Thống kê"),
            SettingsPage()
          ],
        ),
        extendBody: true,
        bottomNavigationBar: RollingBottomBar(
            itemColor: Colors.green,
            color: App_Color.background_textfield,
            controller: _controller,
            flat: true,
            useActiveColorByDefault: false,
            items: [
              RollingBottomBarItem(Icons.home,
                   activeColor: Colors.white),
              RollingBottomBarItem(Icons.person,
                  activeColor: Colors.white),
              RollingBottomBarItem(Icons.bar_chart,
                  activeColor: Colors.white),
              RollingBottomBarItem(Icons.settings,
                  activeColor: Colors.white),
            ],
            enableIconRotation: true,
            onTap: (index) {
              _controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
              );
            }));
  }
}
