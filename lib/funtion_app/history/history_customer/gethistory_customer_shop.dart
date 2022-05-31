import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/funtion_app/history/history_customer/history_customer_shop.dart';
import '../../../model/sc_history/history_customer_shop/history_customer_shops.dart';


class gethistory_customer_shop{

  static Future<void> gethistory(String token) async {
    try{
      constant_history_customer.listhistory_customer_shop.clear();
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Authorization': 'Bearer ${token}'
      };
      var request = http.Request('GET', Uri.parse('${DC_address}/log/customer?customer_id=-1&user_id=-1&sort=desc&status=all'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      constant_history_customer.Jsondata = await response.stream.bytesToString();
      if (json.decode(constant_history_customer.Jsondata)["status"].toString() == "200") {
        for(var history in json.decode(constant_history_customer.Jsondata)["data"]){
          history_customer_shops h_Customer = new history_customer_shops();
          h_Customer.ID_log = history["id"];
          h_Customer.status = history["status"];
          h_Customer.content = history["content"];
          h_Customer.user_id = history["user_id"];
          h_Customer.customer_id = history["customer_id"];
          h_Customer.create_date = history["create_date"];
          constant_history_customer.listhistory_customer_shop.add(h_Customer);
        }
        constant_history_customer.history_customer_shop_sucess = true;
        constant_history_customer.ContentError = json.decode(constant_history_customer.Jsondata)["message"];
      }
      else {
        constant_history_customer.history_customer_shop_sucess = false;
        constant_history_customer.ContentError = json.decode(constant_history_customer.Jsondata)["message"];
        print(response.reasonPhrase);
      }
    }catch(e){
      constant_history_customer.history_customer_shop_sucess = false;
      constant_history_customer.ContentError = json.decode(constant_history_customer.Jsondata)["message"];
    }

  }

}