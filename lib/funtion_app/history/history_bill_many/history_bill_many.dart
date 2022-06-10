import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/funtion_app/history/history_bill_many/history_bil.dart';
import 'package:vldebitor/funtion_app/history/history_creat_credit/history_credit.dart';
import '../../../model/sc_billpayment/sc_billpayment.dart';


class gethistory_bill_many{

  static Future<void> gethistory(int id,String token) async {
    try{
      constant_history_billpayment.listhistory_billpayment.clear();
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Authorization': 'Bearer ${token}'
      };
      var request = http.Request('GET', Uri.parse('${DC_address}/log/transaction?invoice_id=${id}&user_id=1&sort=esc'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      constant_history_billpayment.Jsondata = await response.stream.bytesToString();
      if (json.decode(constant_history_billpayment.Jsondata)["status"].toString() == "200") {
        print(json.decode(constant_history_billpayment.Jsondata)["data"]);
        for(var history in json.decode(constant_history_billpayment.Jsondata)["data"]){
          history_paymentbill h_payment = new history_paymentbill();
          h_payment.id = history["id"];
          h_payment.user = history["user"]["name"];
          h_payment.invoice = history["invoice"]["name"];
          h_payment.payment = history["payment"].toString();
          h_payment.create_date = history["create_date"];
          constant_history_billpayment.listhistory_billpayment.add(h_payment);
        }
        constant_history_billpayment.listhistory_billpayment_sucess = true;
        constant_history_billpayment.ContentError = json.decode(constant_history.Jsondata)["message"];
      }
      else {
        constant_history_billpayment.listhistory_billpayment_sucess = false;
        constant_history_billpayment.ContentError = json.decode(constant_history.Jsondata)["data"];
      }
    }catch(e){
      constant_history.history_credit_sucess = false;
      constant_history.ContentError = e.toString();
    }

  }

}