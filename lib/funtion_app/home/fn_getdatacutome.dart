import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/home/home.dart';
import '../../model/sc_datahome/sc_datahome_customer.dart';

class fn_DataCustomer {
  static Future getDataCustomer(String token) async {
    try {

      constant.ListCustomer_infor_all.clear();
      final prefs = await SharedPreferences.getInstance();
      String DC_address = await prefs.getString("DC_adress").toString();
      print('${DC_address}/customer/info_customers');
      var headers = {'Authorization': 'Bearer ${token}'};
      var request = http.Request(
          'GET', Uri.parse('${DC_address}/customer/info_customers'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      home.datacustomeall = await response.stream.bytesToString();
      if (json.decode(home.datacustomeall)["status"].toString() == "200") {
        for (var i in json.decode(home.datacustomeall)["data"]) {
          sc_datahome_customer datahome_customer = new sc_datahome_customer();
          datahome_customer.ID = i["id"].toString();
          datahome_customer.Name_Custome = i["name"];
          datahome_customer.Phone = i["phone"];
          datahome_customer.Unallocated = i["unallocated"];
          datahome_customer.Total_shop = i["total_shop"];
          datahome_customer.Total_invoice = i["total_invoice"];
          datahome_customer.Total_invoice_paid = i["total_invoice_paid"];
          datahome_customer.Total_payment = i["total_payment"];
          datahome_customer.Total_liabilities = i["total_liabilities"];
          constant.ListCustomer_infor_all.add(datahome_customer);
        }
        home.get_data_Succes = true;
      } else {
        home.get_data_Succes = false;
      }
    } catch (e) {
      home.dataerror = e.toString();
      home.get_data_Succes = false;
    }
  }
}
