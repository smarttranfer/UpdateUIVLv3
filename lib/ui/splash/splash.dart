import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apilogin/fn_login.dart';
import 'package:vldebitor/funtion_app/apilogin/login.dart';
import 'package:vldebitor/theme/Color_app.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'app_icon.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    navigate();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: App_Color.Background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIconWidget(image: 'assets/ic_app/icon_laucher.png'),
          const SizedBox(height: 20),
          SpinKitSpinningLines(
            color: App_Color.green,
            size: 24,
          )
        ],
      ),
    );
  }
  //
  navigate() async {
    await constant.DC_adress();
    final prefs = await SharedPreferences.getInstance();
    String? username =  await prefs.getString("username");
    String? password = await prefs.getString("password");
    if(username.toString().isNotEmpty){
      await fn_login.fn_loginapp(username.toString(), password.toString());
      if(login.LoginSucces==true){
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        Navigator.pushReplacementNamed(context, '/login');
      }
    }else{
      Navigator.pushReplacementNamed(context, '/login');
    }

  }
}
