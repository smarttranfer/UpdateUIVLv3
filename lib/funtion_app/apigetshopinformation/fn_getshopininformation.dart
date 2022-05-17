
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/sc_shop/sc_inforbill.dart';
import '../../model/sc_shop/sc_shop_infor.dart';
import 'getshopinformation.dart';

class getshopinformation{

  static Future<void> getshopinformation_id(int id,String token) async {
      Getshopinformation.data_shop.clear();
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Authorization': 'Bearer ${token}'
      };
      var request = http.Request('GET', Uri.parse('${DC_address}/customer/info/${id}'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      Getshopinformation.Jsondata = await response.stream.bytesToString();
      if (json.decode(Getshopinformation.Jsondata)["status"].toString() == "200") {
        for(var shop in json.decode(Getshopinformation.Jsondata)["data"]["shops"]){
          sc_Infor_Shop shops = new sc_Infor_Shop();
          shops.Shop_ID = shop["id"];
          await getnumberbill(shop["id"],token);
          shops.Name = shop["name"];
          shops.Phone = shop["phone"];
          shops.Payment = shop["payment"];
          shops.street_name = shop["street_name"];
          shops.Post_code = shop["post_code"];
          shops.ID_custome = shop["customer_id"];
          shops.original_amount = shop["original_amount"];
          shops.Create_date = shop["create_date"];
          shops.Building_number = Getshopinformation.data_shop_bill.length;
          Getshopinformation.data_shop.add(shops);
        }
      }
      else {
        print(response.reasonPhrase);
      }
  }
  static Future<void> getnumberbill (int id,String token) async {
    Getshopinformation.data_shop_bill.clear();
    final prefs = await SharedPreferences.getInstance();
    String DC_address = await prefs.getString("DC_adress").toString();
    var headers = {
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request('GET', Uri.parse('${DC_address}/invoice/all_by_shop/${id}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Getshopinformation.Jsondata = await response.stream.bytesToString();
    if (json.decode(Getshopinformation.Jsondata)["status"].toString() == "200") {
      print(json.decode(Getshopinformation.Jsondata)["data"]["invoices"]);
      for(var bill in json.decode(Getshopinformation.Jsondata)["data"]["invoices"]){
        sc_Infor_Shop_Bill shops_bill = new sc_Infor_Shop_Bill();
        shops_bill.ID = bill["id"];
        shops_bill.Name = bill["name"];
        shops_bill.Payment = bill["payment"];
        shops_bill.Content = bill["content"];
        shops_bill.Original_amount = bill["original_amount"];
        shops_bill.Shop_ID = bill["shop_id"];
        shops_bill.Create_date = bill["create_date"];
        Getshopinformation.data_shop_bill.add(shops_bill);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

}