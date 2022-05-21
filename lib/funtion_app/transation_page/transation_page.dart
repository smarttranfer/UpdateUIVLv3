import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'app_router.dart';

class transation_page{
  static void transation_router(Widget Page,int option){
    if(option == 1){
      AppRouter.navigatorKey.currentState?.pushReplacement(PageTransition(type: PageTransitionType.rightToLeft, duration: Duration(seconds: 1), child: Page));
    }else{
      AppRouter.navigatorKey.currentState?.pushReplacement(PageTransition(type: PageTransitionType.leftToRight,duration: Duration(seconds: 1), child: Page));
    }
  }

}