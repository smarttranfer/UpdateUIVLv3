import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/funtion_app/apipayment/Payment.dart';

class fn_payment{
  static Future Payment(double payment,int CustomeId, String token,int invoice_id) async{
    final prefs = await SharedPreferences.getInstance();
    String DC_address = await prefs.getString("DC_adress").toString();
    var headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${DC_address}/transaction'));
    request.body = json.encode({
      "customer_id": CustomeId,
      "unallocated": 0.0,
      "invoices": [
        {
          "invoice_id": invoice_id,
          "payment": payment
        },
      ]
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    payments.Jsondata = await response.stream.bytesToString();
    if (json.decode(payments.Jsondata)["status"].toString() == "200") {
      payments.Create_payment_Succes=true;
    }
    else {
      payments.Create_payment_Succes=false;
      payments.ContentError = json.decode(payments.Jsondata)["data"];

    }

  }


}