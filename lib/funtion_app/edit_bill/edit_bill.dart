import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/funtion_app/apiedit_customer/apiedit_customer.dart';
import 'package:vldebitor/funtion_app/edit_bill/status_edit.dart';

class fn_edit_bill {
  static Future<void> fn_edit_bills(
      int id_bill, String name, double Money, String Note ,String date , String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}'
      };
      var request = await http.Request('PUT', Uri.parse("${DC_address}/invoice/${id_bill}"));
      request.body = json.encode({
        "name": "${name}",
        "original_amount": Money,
        "content": "${Note}",
        "create_date": "${date}"
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      edit_bill.dataedit_bill = await response.stream.bytesToString();
      print(edit_bill.dataedit_bill);
      if (json.decode(edit_bill.dataedit_bill)["status"].toString() == "200") {
        edit_bill.edit_bills = true;
      } else {
        edit_bill.edit_bills = false;
        edit_bill.edit_bill_error = json.decode(edit_bill.dataedit_bill)["data"].toString();
      }
    } catch (e) {
      edit_bill.edit_bill_error = e.toString();
    }
  }
}
