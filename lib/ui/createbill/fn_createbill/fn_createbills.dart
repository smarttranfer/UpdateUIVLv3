import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/ui/createbill/fn_createbill/createbill_status.dart';

class CreaterInvoid {
  static Future CreaterInvoids(
      String token, String name, double money , double id,String date) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${DC_address}/invoice'));
      request.body = json.encode({
        "name": "${name}",
        "original_amount": money,
        "content": "${money}",
        "shop_id": id,
        "create_date": "${date}"
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      createbill.Jsondata = await response.stream.bytesToString();
      if (json.decode(createbill.Jsondata)["status"].toString() == "200") {
        createbill.Create_Bill_Succes = true;
      } else {
        createbill.Create_Bill_Succes = false;
      }
    } catch (e) {}
  }
}
