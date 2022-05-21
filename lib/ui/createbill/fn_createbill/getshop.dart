
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../model/sc_createbill/sc_createbill.dart';
import 'getshopdata.dart';

class getshopinformation_createbills{

  static Future<void> getshopinformation_id(int id,String token) async {
    Getshopinformation_createbill.data_shop.clear();
    final prefs = await SharedPreferences.getInstance();
    String DC_address = await prefs.getString("DC_adress").toString();
    var headers = {
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request('GET', Uri.parse('${DC_address}/shop/info_shops_by_customer_id/${id}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Getshopinformation_createbill.Jsondata = await response.stream.bytesToString();
    if (json.decode(Getshopinformation_createbill.Jsondata)["status"].toString() == "200") {
      for(var shop in json.decode(Getshopinformation_createbill.Jsondata)["data"]){
        sc_Create_bill shops = new sc_Create_bill();
        shops.ID = shop["id"];
        shops.Name = shop["name"];
        Getshopinformation_createbill.data_shop.add(shops);
      }
      Getshopinformation_createbill.GetshopinformationSucces_createbill=true;
    }
    else {
      Getshopinformation_createbill.GetshopinformationSucces_createbill=false;
    }
  }

}