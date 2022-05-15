import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class constant {
  static Future<void> DC_adress() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'DC_adress',"http://159.223.52.212:27554");
  }
}