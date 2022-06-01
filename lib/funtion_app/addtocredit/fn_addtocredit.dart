import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'addtocreadit.dart';

class fn_AddToCredit{
  static Future AddtoCredits(double unallocated,int CustomeId, String token) async{
    final prefs = await SharedPreferences.getInstance();
    String DC_address = await prefs.getString("DC_adress").toString();
    var headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${DC_address}/transaction'));
    request.body = json.encode({
      "customer_id": CustomeId,
      "unallocated": unallocated,
      "invoices": []
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    AddCredit_check.Jsondata = await response.stream.bytesToString();
    print(AddCredit_check.Jsondata);
    if (json.decode(AddCredit_check.Jsondata)["status"].toString() == "200") {
      AddCredit_check.AddCredit_Succes=true;
    }
    else {
      AddCredit_check.AddCredit_Succes=false;
      AddCredit_check.ContentError = json.decode(AddCredit_check.Jsondata)["message"];

    }

  }


}