import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:money_formatter/money_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetshopinformation/fn_getshopininformation.dart';
import 'package:vldebitor/funtion_app/apigetshopinformation/getshopinformation.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../funtion_app/apigetshopinformation/getshopinformation.dart';
import '../../provider/manager_credit.dart';
import '../../utilities/constants.dart';
import '../../widget/cardshop.dart';
import '../home/home.dart';
import '../shopregister/shopregisterinshop.dart';

class Shoplist extends StatefulWidget {
  late String title;
  Shoplist({Key? key, required this.title}) : super(key: key);

  @override
  _Shoplist createState() => _Shoplist();
}

class _Shoplist extends State<Shoplist> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _foundUsers = [];
  String searchString = "";
  String status = "No Data";
  bool checknull = false;
  bool check_loding_data = true;

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    results.clear();
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers.where((user) => user["name"].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      if(results.isEmpty){
        results = _allUsers.where((user) => user["building_number"].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      }
    }
    setState(() {
      _foundUsers = results;
    });
  }
  @override
  void initState() {
    mapData();
  }
  Future<void> mapData()async {
    for (var shop in Getshopinformation.data_shop) {
      _allUsers.add({
      "id": shop.Shop_ID,
      "name": shop.Name,
      "phone": null,
      "building_number": shop.Building_number,
      "street_name": shop.street_name,
      "post_code": shop.Post_code,
      "total_invoice": shop.Total_invoice,
      "total_invoice_paid": shop.Total_invoice_paid,
      "total_payment": shop.Total_payment,
      "total_liabilities": shop.Total_liabilities,
      "create_date": shop.Create_date,

      });
    }
    _foundUsers = _allUsers;
  }

  void _onRefresh() async {
    setState(() {
      status = "Get Data";
      Getshopinformation.data_shop = [];
    });
    await Future.delayed(Duration(milliseconds: 1000));
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    await getshopinformation.getshopinformation_id(
        constant.indexcustomer, token);
    if (Getshopinformation.GetshopinformationSucces == true) {
      setState(() {
        status = "Get Data";
        Getshopinformation.data_shop = Getshopinformation.data_shop;
      });
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    setState(() {
      status = "Get Data";
      Getshopinformation.data_shop = [];
    });
    await Future.delayed(Duration(milliseconds: 1000));
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token").toString();
    await getshopinformation.getshopinformation_id(
        constant.indexcustomer, token);
    if (Getshopinformation.GetshopinformationSucces == true) {
      setState(() {
        status = "Get Data";
        Getshopinformation.data_shop = Getshopinformation.data_shop;
      });
      _refreshController.loadComplete();
    } else {
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    MoneyFormatter Format_credit = MoneyFormatter(amount: double.parse(Provider.of<managen_credit>(context, listen: true).CreditResult()));
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Home_page()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: App_Color.Background,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          )),
          actions: [
            Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ShopregisterScreeninShop()));
                  },
                  child: Container(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                ))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          color: App_Color.Background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                alignment: Alignment.centerLeft,
                decoration: kBoxDecorationStyle,
                height: 44.0,
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                  onChanged: (value) {
                    return _runFilter(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Tìm kiếm',
                    hintStyle: kHintTextStyle,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                    decoration:  BoxDecoration(
                      color: App_Color.Background,
                    ),
                  padding: EdgeInsets.all(8),
                  child: Container(
                      decoration: kBoxDecorationStyle_credit,
                      height: 80.0,
                      // width: MediaQuery.of(context).size.width/1.19,
                      margin: EdgeInsets.only(bottom: 8,),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Số dư tài khoản",
                              style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: 'OpenSans',
                              )),
                          Text("${Format_credit.output.nonSymbol}",style: TextStyle(
                            color: double.parse(Provider.of<managen_credit>(context, listen: true).CreditResult())>0?App_Color.green:Colors.red,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'OpenSans',
                          ))
                        ],
                      ))),
              Expanded(
                  child: SingleChildScrollView(
                      child: Container(
                child: _foundUsers.isEmpty
                    ? Center(
                        child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(status,
                              textStyle: TextStyle(color: App_Color.green)),
                        ],
                        isRepeatingAnimation: true,
                      ))
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.55,
                        child: SmartRefresher(
                            physics: const BouncingScrollPhysics(),
                            enablePullDown: true,
                            enablePullUp: false,
                            header: WaterDropHeader(
                              waterDropColor: App_Color.green,
                              complete: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(Icons.done, color: Colors.green),
                                  const SizedBox(width: 15.0),
                                  Text(
                                    update_SC,
                                    style: TextStyle(color: App_Color.green),
                                  )
                                ],
                              ),
                              failed: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(Icons.error_outline,
                                      color: Colors.red),
                                  const SizedBox(width: 15.0),
                                  Text(
                                    update_F,
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                            controller: _refreshController,
                            onLoading: _onLoading,
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                                itemCount: _foundUsers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Shoplistcard(
                                      index,
                                      _foundUsers[index]["id"],
                                      _foundUsers[index]["name"],
                                      "${_foundUsers[index]["building_number"]}, ${_foundUsers[index]["street_name"]}, ${_foundUsers[index]["post_code"]}",
                                      _foundUsers[index]["building_number"].toString(),
                                      _foundUsers[index]["street_name"].toString(),
                                      _foundUsers[index]["post_code"].toString(),
                                      _foundUsers[index]["total_invoice_paid"].toString(),
                                      _foundUsers[index]["total_invoice"].toString(),
                                      _foundUsers[index]["total_payment"].toString(),
                                      _foundUsers[index]["total_liabilities"].toString(),
                                      _foundUsers[index]["create_date"].toString());
                                }))),
              )))
            ],
          ),
        ));
  }
}
