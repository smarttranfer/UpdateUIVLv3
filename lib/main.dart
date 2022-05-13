import 'package:flutter/material.dart';
import 'package:vldebitor/ui/customelist/customelist.dart';
import 'package:vldebitor/ui/home/home.dart';
import 'package:vldebitor/ui/login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home':(context)=> Home_page(),
        '/liscustome':(context)=> Customelist(),
      },
    );
  }
}
