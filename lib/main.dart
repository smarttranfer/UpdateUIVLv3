import 'package:flutter/material.dart';
import 'package:vldebitor/ui/addbill/addbill.dart';
import 'package:vldebitor/ui/customelist/customelist.dart';
import 'package:vldebitor/ui/customeregistry/customeregistry.dart';
import 'package:vldebitor/ui/home/home.dart';
import 'package:vldebitor/ui/login/login_screen.dart';
import 'package:vldebitor/ui/shop/detail/detail.dart';
import 'package:vldebitor/ui/shop/shop.dart';
import 'package:vldebitor/ui/shopregister/shopregister.dart';
import 'package:vldebitor/ui/shopregister/shopregisterinshop.dart';
import 'package:vldebitor/ui/splash/splash.dart';

import 'funtion_app/transation_page/app_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppRouter.navigatorKey,
      title: 'Debiter Vl Lodon App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => Home_page(),
        '/liscustome': (context) => Customelist(),
        '/registerCustome': (context) => CustomeregisterScreen(),
        '/registerShop': (context) => ShopregisterScreen(),
        '/shoplist':(context)=>Shoplist(),
        '/registershopnew':(context)=>ShopregisterScreeninShop(),
        '/shopdetail':(context)=>DetailScreen(),
        '/billlist':(context)=>Billlist()
      },
    );
  }
}


