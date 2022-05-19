import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'addtocreadit.dart';

class AddToCredit{
  static Future AddtoCredits(double unallocated,int CustomeId, String token) async{
    final prefs = await SharedPreferences.getInstance();
    String DC_address = await prefs.getString("DC_adress").toString();
    var headers = {
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request('GET', Uri.parse('${DC_address}/transaction'));
    request.body = json.encode({
      "customer_id": CustomeId,
      "unallocated": unallocated,
      "invoices": []
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    AddCredit.Jsondata = await response.stream.toString();
    if (json.decode(AddCredit.Jsondata)["status"].toString() == "200") {
      AddCredit.AddCredit_Succes=true;
      print(await response.stream.bytesToString());
    }
    else {
      AddCredit.AddCredit_Succes=false;
      AddCredit.ContentError = json.decode(AddCredit.Jsondata)["data"];
      print(response.reasonPhrase);
    }

  }


}