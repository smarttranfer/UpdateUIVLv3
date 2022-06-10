import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
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
      Develop(Tilte:"Thống kê"),
      SettingsPage()
    ];
    return Scaffold(
        appBar: AppBar(
        title: Text('Rolling Bottom Bar'),
    ),
    body: PageView(
    controller: _controller,
    children: <Widget>[
    ColoredBox(color: Colors.blueGrey.shade100),
    ColoredBox(color: Colors.redAccent),
    ColoredBox(color: Colors.greenAccent),
    ColoredBox(color: Colors.yellowAccent),
    ],
    ),
    extendBody: true,
    bottomNavigationBar: RollingBottomBar(
    controller: _controller,
    flat: true,
    useActiveColorByDefault: false,
    items: [
    RollingBottomBarItem(Icons.home, label: 'Page 1', activeColor: Colors.redAccent),
    RollingBottomBarItem(Icons.star, label: 'Page 2', activeColor: Colors.blueAccent),
    RollingBottomBarItem(Icons.person, label: 'Page 3', activeColor: Colors.yellowAccent),
    RollingBottomBarItem(Icons.access_alarm, label: 'Page 4', activeColor: Colors.orangeAccent),
    ],
    enableIconRotation: true,
    onTap: (index) {
    _controller.animateToPage(
    index,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeOut,
    )}));
  }
}
