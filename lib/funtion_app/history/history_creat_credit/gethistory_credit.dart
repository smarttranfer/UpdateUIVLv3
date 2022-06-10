import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/funtion_app/history/history_creat_credit/history_credit.dart';
import '../../../model/sc_history/history_credit/history_credit.dart';


class gethistory_credit{

  static Future<void> gethistory(int idcustome,String token) async {
    try{
      constant_history.listhistory_credit.clear();
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      var headers = {
        'Authorization': 'Bearer ${token}'
      };
      var request = http.Request('GET', Uri.parse('${DC_address}/log/credit?customer_id=${idcustome}&user_id=-1&sort=esc'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      constant_history.Jsondata = await response.stream.bytesToString();
      if (json.decode(constant_history.Jsondata)["status"].toString() == "200") {
        for(var history in json.decode(constant_history.Jsondata)["data"]){
          history_credit h_credit = new history_credit();
          h_credit.ID_log = history["id"];
          h_credit.credit = history["credit"];
          h_credit.user_id = history["user"]["name"];
          h_credit.customer_id = history["customer"]["name"];
          h_credit.create_date = history["create_date"];
          constant_history.listhistory_credit.add(h_credit);
        }
        constant_history.history_credit_sucess = true;
        constant_history.ContentError = json.decode(constant_history.Jsondata)["message"];
      }
      else {
        constant_history.history_credit_sucess = false;
        constant_history.ContentError = json.decode(constant_history.Jsondata)["data"];
      }
    }catch(e){
      constant_history.history_credit_sucess = false;
      constant_history.ContentError = e.toString();
    }

  }

}