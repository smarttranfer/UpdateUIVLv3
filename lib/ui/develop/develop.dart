import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetshopinformation/fn_getshopininformation.dart';
import 'package:vldebitor/funtion_app/apigetshopinformation/getshopinformation.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../utilities/constants.dart';
import '../../widget/cardshop.dart';
import '../home/home.dart';
import '../shopregister/shopregisterinshop.dart';

class Develop extends StatefulWidget {
  late String Tilte;

  Develop({Key? key,required this.Tilte}) : super(key: key);

  @override
  _Develop createState() => _Develop();
}

class _Develop extends State<Develop> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _foundUsers = [];
  String searchString = "";
  String status= "No Data";
  bool checknull = false;
  bool check_loding_data = true;

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers = results;
    });
  }

  void _onRefresh() async {
    setState(() {
      status = "Get Data";
      Getshopinformation.data_shop=[];
    });
    await Future.delayed(Duration(milliseconds: 1000));
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    await getshopinformation.getshopinformation_id(constant.indexcustomer,token);
    if (Getshopinformation.GetshopinformationSucces==true){

      setState(() {
        status = "Get Data";
        Getshopinformation.data_shop=Getshopinformation.data_shop;
      });
      _refreshController.refreshCompleted();
    }else{
      _refreshController.refreshFailed();
    }

  }

  void _onLoading() async {
    setState(() {
      status = "Get Data";
      Getshopinformation.data_shop=[];
    });
    await Future.delayed(Duration(milliseconds: 1000));
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token").toString();
    await getshopinformation.getshopinformation_id(constant.indexcustomer,token);
    if(Getshopinformation.GetshopinformationSucces==true){
      setState(() {
        status = "Get Data";
        Getshopinformation.data_shop=Getshopinformation.data_shop;
      });
      _refreshController.loadComplete();
    }else{
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: App_Color.Background,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
                widget.Tilte,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          actions: [

          ],
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          color: App_Color.Background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                alignment: Alignment.center,

                height: 44.0,
                child: Text("It's in the process of development",style: TextStyle(color: Colors.white),)
              ),
              SizedBox(height: 5),

            ],
          ),
        ));
  }
}
