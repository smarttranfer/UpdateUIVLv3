import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/funtion_app/apiregistercustomer/registercustomer.dart';
import 'package:vldebitor/funtion_app/home/home.dart';

class CreaterCustomer {
  static Future CreaterCustomers(
      String token, String name, String phone) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${DC_address}/customer'));
      request.body = json.encode({
        "name": "${name}",
        "phone": "${phone}",
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      registercustomer.Jsondata = await response.stream.bytesToString();
      if (json.decode(registercustomer.Jsondata)["status"].toString() == "200") {
        registercustomer.Create_Customer_Succes = true;
        prefs.setInt("id_custome", json.decode(registercustomer.Jsondata)["data"]["id"]);
      } else {
        registercustomer.Create_Customer_Succes = false;
        registercustomer.ContentError = json.decode(registercustomer.Jsondata)["data"];
      }
    } catch (e) {}
  }
}
