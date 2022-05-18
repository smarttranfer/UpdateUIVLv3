import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/sc_datahome/sc_datahome_customer.dart';

class constant {
  static Future<void> DC_adress() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'DC_adress',"http://159.223.52.212:27554");
  }
  static int indexshop = 0;
  static int indexcustomer = 0;
  static String TitleApp_Bar = "";
  static bool ButtonEnble = false;
  static String user = "";
  static List<sc_datahome_customer> ListCustomer_infor_all = [];
}