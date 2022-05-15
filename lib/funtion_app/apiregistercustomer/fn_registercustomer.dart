import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/funtion_app/apiregistercustomer/registercustomer.dart';
import 'package:vldebitor/funtion_app/home/home.dart';


class CreaterCustomer{
  static Future CreaterCustomers(String token) async{
    final prefs = await SharedPreferences.getInstance();
    String DC_address = await prefs.getString("DC_adress").toString();
    var headers = {
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request('GET', Uri.parse('${DC_address}/customer'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    home.datacustomeall = await response.stream.bytesToString();
    if (json.decode(home.datacustomeall)["status"].toString() == "200") {
      registercustomer.Create_Customer_Succes = true;
    }
    else {
      print(response.reasonPhrase);
    }
  }


}