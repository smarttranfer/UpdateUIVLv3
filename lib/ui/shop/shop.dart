import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetshopinformation/getshopinformation.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../model/sc_datahome/sc_datahome_customer.dart';
import '../../utilities/constants.dart';
import '../../widget/cardshop.dart';

class Shoplist extends StatefulWidget {
  Shoplist({Key? key}) : super(key: key);

  @override
  _Shoplist createState() => _Shoplist();
}

class _Shoplist extends State<Shoplist> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _foundUsers = [];
  String searchString = "";
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
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  int numbershop(List<sc_datahome_customer> listshop) {
    int number_shop = 0;
    for (var i in listshop) {
      number_shop += i.ListBills.length;
    }
    return number_shop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: App_Color.Background,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            "Shops List",
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/registershopnew', (Route<dynamic> route) => false);
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
                    hintText: 'Search',
                    hintStyle: kHintTextStyle,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                  child: SingleChildScrollView(
                      child: Container(
                child: Getshopinformation.data_shop.isEmpty
                    ? Center(
                        child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText("Not Data",
                              textStyle: TextStyle(color: App_Color.green)),
                        ],
                        isRepeatingAnimation: true,
                      ))
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: SmartRefresher(
                            physics: const BouncingScrollPhysics(),
                            enablePullDown: true,
                            enablePullUp: true,
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
                                itemCount: Getshopinformation.data_shop.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Shoplistcard(
                                      Getshopinformation.data_shop[index].Name,
                                      Getshopinformation
                                          .data_shop[index].street_name,
                                      Getshopinformation
                                          .data_shop[index].Building_number
                                          .toString(),
                                      Getshopinformation
                                          .data_shop[index].original_amount
                                          .toString(),
                                      Getshopinformation
                                          .data_shop[index].Create_date
                                          .toString());
                                }))),
              )))
            ],
          ),
        ));
  }
}
