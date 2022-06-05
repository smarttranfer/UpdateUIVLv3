import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/funtion_app/apiedit_customer/apiedit_customer.dart';

class fn_edit_customer {
  static Future<void> fn_edit_customers(
      int IDCustomer, String NameCustomer, String Phone, String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}'
      };
      var request = await http.Request('PUT', Uri.parse("${DC_address}/customer/${IDCustomer}"));
      request.body = json.encode({"name": "${NameCustomer}", "phone": "${Phone}"});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      edit_customer.dataedit_customer = await response.stream.bytesToString();
      if (json.decode(edit_customer.dataedit_customer)["status"].toString() == "200") {
        edit_customer.edit_customers = true;
      } else {
        edit_customer.edit_customers = false;
        edit_customer.edit_customer_error =
            json.decode(edit_customer.dataedit_customer)["data"].toString();
      }
    } catch (e) {
      edit_customer.edit_customer_error = e.toString();
    }
  }
}
