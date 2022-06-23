import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apilogin/login.dart';

class fn_login {
  static Future<void> fn_loginapp(String username, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {'Content-Type': 'application/json'};
      var request = await http.Request('POST', Uri.parse("${DC_address}/auth/login"));
      request.body = json.encode({"username": "${username}", "password": "${password}"});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      login.datalogin = await response.stream.bytesToString();
      if (json.decode(login.datalogin)["status"].toString() == "200") {
        login.LoginSucces = true;
        constant.user = username;
        await prefs.setString('token', json.decode(login.datalogin)["data"]["token"].toString());
        List<String> rule = [];
        for (String rules in json.decode(login.datalogin)["data"]["roles"]) {
          rule.add(rules);
        }
        await prefs.setStringList("rule", rule);
      } else {
        login.LoginSucces = false;
        login.dataError = json.decode(login.datalogin)["data"].toString();
        await prefs.setString('token', "");
        await prefs.setStringList("rule", []);
      }
    } catch (e) {
      login.LoginSucces = false;
      login.dataError = e.toString();
    }
  }
}
