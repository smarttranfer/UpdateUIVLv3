import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vldebitor/funtion_app/home/home.dart';


class DataCustomer{
  Future getDataCustomer(String token) async{
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

    }
    else {
      print(response.reasonPhrase);
    }
  }


}