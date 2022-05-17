import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/home/home.dart';
import 'package:vldebitor/model/sc_datahome/sc_datahome_bill.dart';

import '../../model/sc_datahome/sc_datahome_customer.dart';


class fn_DataCustomer{
  static Future getDataCustomer(String token) async{
    constant.ListCustomer_infor_all.clear();
    final prefs = await SharedPreferences.getInstance();
    String DC_address = await prefs.getString("DC_adress").toString();
    var headers = {
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request('GET', Uri.parse('${DC_address}/customer/info/all'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    home.datacustomeall = await response.stream.bytesToString();
    if (json.decode(home.datacustomeall)["status"].toString() == "200") {
      for(var i in json.decode(home.datacustomeall)["data"]){
        sc_datahome_customer datahome_customer = new sc_datahome_customer();
        datahome_customer.ID = i["id"].toString();
        datahome_customer.Name_Custome = i["name"];
        datahome_customer.Phome = i["phone"];
        for(var shops in i["shops"]){
          sc_datahome_bill datahome_bill = new sc_datahome_bill();
          datahome_bill.ID = shops["id"].toString();
          datahome_bill.Name = shops["name"];
          datahome_bill.Phome = shops["phone"];
          datahome_bill.Payment = double.parse(shops["payment"].toString()).toString();
          datahome_bill.Street_name = shops["street_name"];
          datahome_bill.Post_code = shops["post_code"];
          datahome_bill.Customer_id = shops["customer_id"].toString();
          datahome_bill.Original_amount = shops["original_amount"].toString();
          datahome_bill.Create_date = shops["create_date"];
          datahome_customer.ListBills.add(datahome_bill);
        }
        constant.ListCustomer_infor_all.add(datahome_customer);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }


}