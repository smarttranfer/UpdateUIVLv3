import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/funtion_app/apiedit_customer/editshop/apiedit_shop.dart';

class fn_edit_shop{
  static Future<void> fn_edit_shops(int IDShop, String NameShop, String building_number, String street_name,String post_code,String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}'
      };
      var request = await http.Request('PUT', Uri.parse("${DC_address}/shop/${IDShop}"));
      request.body = json.encode({
        "name": "${NameShop}",
        "building_number": "${building_number}",
        "street_name": "${street_name}",
        "phone": "",
        "post_code": "${post_code}"});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      edit_shop.dataedit_shop = await response.stream.bytesToString();
      if (json.decode(edit_shop.dataedit_shop)["status"].toString() == "200") {
        edit_shop.edit_shops = true;
      } else {
        edit_shop.edit_shops = false;
        edit_shop.edit_shop_error = json.decode(edit_shop.dataedit_shop)["data"].toString();
      }
    } catch (e) {}
  }
}
