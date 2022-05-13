import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar(
      this.title, {
        Key ?key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height =
        (mediaQuery.size.height - mediaQuery.padding.top) * 10;
    return Container(
      height: height,
      child: Row(
        children: <Widget>[
          Text(title)
        ],
      ),
    );
  }
}