import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'deletecustomer.dart';


class DeleteCustomer{
  static Future DeleteCustomers(int Id_Customer , String token) async{
    final prefs = await SharedPreferences.getInstance();
    String DC_address = await prefs.getString("DC_adress").toString();
    var headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse('${DC_address}/customer/${Id_Customer}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Deletecustomer.Jsondata = await response.stream.bytesToString();
    if (json.decode(Deletecustomer.Jsondata)["status"].toString() == "200") {
      Deletecustomer.Delete_Customer_Succes = true;
    }
    else {
      Deletecustomer.Delete_Customer_Succes = false;
      Deletecustomer.ContentError = json.decode(Deletecustomer.Jsondata)["message"];
      print(response.reasonPhrase);
    }

  }

}