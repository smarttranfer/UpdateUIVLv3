
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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
      var request = http.Request('GET', Uri.parse('${DC_address}/shop/info_shops_by_customer_id/${id}'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      Getshopinformation.Jsondata = await response.stream.bytesToString();
      if (json.decode(Getshopinformation.Jsondata)["status"].toString() == "200") {
        for(var shop in json.decode(Getshopinformation.Jsondata)["data"]){
          sc_Infor_Shop shops = new sc_Infor_Shop();
          shops.Shop_ID = shop["id"];
          shops.Name = shop["name"];
          shops.Building_number = shop["building_number"];
          shops.street_name = shop["street_name"];
          shops.Post_code = shop["post_code"];
          shops.Total_invoice = shop["total_invoice"];
          shops.Total_payment = shop["total_payment"];
          shops.Total_liabilities = shop["total_liabilities"];
          shops.Create_date = shop["create_date"];
          shops.Total_invoice_paid = shop["total_invoice_paid"];
          Getshopinformation.data_shop.add(shops);
        }
        Getshopinformation.GetshopinformationSucces=true;
      }
      else {
        Getshopinformation.GetshopinformationSucces=false;
        print(response.reasonPhrase);
      }
  }

}