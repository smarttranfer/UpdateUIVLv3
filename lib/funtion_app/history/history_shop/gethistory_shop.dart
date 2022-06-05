import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/funtion_app/history/history_customer/history_customer_shop.dart';
import 'package:vldebitor/funtion_app/history/history_shop/history_shop.dart';
import '../../../model/sc_history/history_customer_shop/history_customer_shops.dart';



class gethistory_shop{

  static Future<void> gethistory(String token, int ID) async {
    try{
      constant_history_customer.listhistory_customer_shop.clear();
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Authorization': 'Bearer ${token}'
      };
      var request = http.Request('GET', Uri.parse('${DC_address}/log/shop?shop_id=${ID}&user_id=-1&sort=desc&status=all'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      constant_history_shop.Jsondata = await response.stream.bytesToString();
      if (json.decode(constant_history_shop.Jsondata)["status"].toString() == "200") {
        for(var history in json.decode(constant_history_shop.Jsondata)["data"]){
          history_customer_shops h_Shop = new history_customer_shops();
          h_Shop.ID_log = history["id"];
          h_Shop.status = history["status"];
          h_Shop.content = history["content"];
          h_Shop.user_id = history["user"]["name"];
          h_Shop.shop_id = history["shop"]["name"];
          h_Shop.create_date = history["create_date"];
          constant_history_shop.listhistory_customer_shop.add(h_Shop);
        }
        constant_history_shop.history_customer_shop_sucess = true;
        constant_history_shop.ContentError = json.decode(constant_history_shop.Jsondata)["message"];
      }
      else {
        constant_history_shop.history_customer_shop_sucess = false;
        constant_history_shop.ContentError = json.decode(constant_history_shop.Jsondata)["data"];
      }
    }catch(e){
      constant_history_shop.history_customer_shop_sucess = false;
      constant_history_shop.ContentError = e.toString();
    }

  }

}