import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/funtion_app/apiregistershop/registershop.dart';

class CreaterShop {
  static Future CreaterShops(
      String token, String name, String phone,String Address,String Postcode,int Ct_id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${DC_address}/customer'));
      request.body = json.encode({
        "name": "${name}",
        "building_number": "VL build",
        "street_name": "${Address}",
        "phone": "${phone}",
        "post_code": "${Postcode}",
        "customer_id": Ct_id
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      registershop.Jsondata = await response.stream.bytesToString();
      print(json.decode(registershop.Jsondata ));
      if (json.decode(registershop.Jsondata )["status"].toString() == "200") {
        registershop.Create_Shop_Succes = true;
      } else {
        registershop.Create_Shop_Succes = false;
        registershop.ContentError = json.decode(registershop.Jsondata)["data"].toString();
      }
    } catch (e) {}
  }
}
