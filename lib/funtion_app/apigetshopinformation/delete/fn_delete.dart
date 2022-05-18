import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'delete.dart';


class Deleteshops{
  static Future Deleteshopfuntion(int Id_Customer , String token) async{
    final prefs = await SharedPreferences.getInstance();
    String DC_address = await prefs.getString("DC_adress").toString();
    var headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse('${DC_address}/customer/${Id_Customer}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    DeleteShop.Jsondata = await response.stream.bytesToString();
    if (json.decode(DeleteShop.Jsondata)["status"].toString() == "200") {
      DeleteShop.Delete_shop_Succes = true;
    }
    else {
      DeleteShop.Delete_shop_Succes = false;
      DeleteShop.ContentError = json.decode(DeleteShop.Jsondata)["message"];
      print(response.reasonPhrase);
    }

  }

}