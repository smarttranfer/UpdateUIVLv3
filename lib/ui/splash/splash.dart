import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vldebitor/theme/Color_app.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../login/login_screen.dart';
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
    Future.delayed(Duration.zero,()async{
      Navigator.pushReplacementNamed(context, '/login');
    });

    // Navigator.of(context).pushNamedAndRemoveUntil(
    //     '/login', (Route<dynamic> route) => false);
  }
}
