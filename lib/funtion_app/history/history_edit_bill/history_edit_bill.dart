import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/funtion_app/history/history_edit_bill/history_status_edit_bill.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/sc_edit_bill/sc_edit_bill.dart';


class gethistory_edit_bill{

  static Future<void> gethistory(String token,int id_bill) async {
    try{
      constant_history_bill.listhistory_edit_bill.clear();
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Authorization': 'Bearer ${token}'
      };
      var request = http.Request('GET', Uri.parse('${DC_address}/log/invoice?invoice_id=${id_bill}&user_id=-1&sort=desc&status=all'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      constant_history_bill.Jsondata = await response.stream.bytesToString();

      if (json.decode(constant_history_bill.Jsondata)["status"].toString() == "200") {
        for(var history in json.decode(constant_history_bill.Jsondata)["data"]){
          history_edit_bill h_Customer = new history_edit_bill();
          h_Customer.ID_log = history["id"];
          h_Customer.status = history["status"];
          h_Customer.content = history["content"];
          h_Customer.user = history["user"]["name"];
          h_Customer.invoice = history["invoice"]["name"];
          h_Customer.create_date = history["create_date"];
          constant_history_bill.listhistory_edit_bill.add(h_Customer);
        }
        print(constant_history_bill.listhistory_edit_bill.length);
        constant_history_bill.history_edit_bill_sucess = true;
        constant_history_bill.ContentError = json.decode(constant_history_bill.Jsondata)["message"];
      }
      else {
        constant_history_bill.history_edit_bill_sucess = false;
        constant_history_bill.ContentError = json.decode(constant_history_bill.Jsondata)["data"];
      }
    }catch(e){
      constant_history_bill.history_edit_bill_sucess = false;
      constant_history_bill.ContentError =e.toString();
    }

  }

}