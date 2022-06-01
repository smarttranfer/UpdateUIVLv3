import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/sc_bill/sc_data_bill.dart';
import 'apigetbill.dart';

class getbillinformation{

  static Future<void> getbill(int id,String token) async {
    Getbillinformation.data_bill.clear();
    final prefs = await SharedPreferences.getInstance();
    String DC_address = await prefs.getString("DC_adress").toString();
    var headers = {
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request('GET', Uri.parse('${DC_address}/invoice/all_by_shop/${id}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Getbillinformation.Jsondata = await response.stream.bytesToString();
    if (json.decode(Getbillinformation.Jsondata)["status"].toString() == "200") {
      for(var bills in json.decode(Getbillinformation.Jsondata)["data"]["invoices"]){
        sc_data_bill bill = new sc_data_bill();
        bill.ID = bills["id"];
        bill.Name = bills["name"];
        bill.payment = bills["payment"];
        bill.content = bills["content"];
        bill.status = bills["status"];
        bill.original_amount = bills["original_amount"];
        bill.user_id = bills["user_id"];
        bill.shop_id = bills["shop_id"];
        bill.transaction_status = bills["transaction_status"];
        bill.create_date = bills["create_date"];
        Getbillinformation.data_bill.add(bill);
      }
      Getbillinformation.GetbillinformationSucces = true;
      Getbillinformation.ContentError = json.decode(Getbillinformation.Jsondata)["message"];
    }
    else {
      Getbillinformation.GetbillinformationSucces = false;
      Getbillinformation.ContentError = json.decode(Getbillinformation.Jsondata)["message"];
      print(response.reasonPhrase);
    }
  }

}