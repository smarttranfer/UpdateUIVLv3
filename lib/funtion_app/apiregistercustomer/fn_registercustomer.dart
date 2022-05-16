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
      home.datacustomeall = await response.stream.bytesToString();
      print(home.datacustomeall);
      if (json.decode(home.datacustomeall)["status"].toString() == "200") {
        registercustomer.Create_Customer_Succes = true;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {}
  }
}
