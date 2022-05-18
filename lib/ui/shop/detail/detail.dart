import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../../funtion_app/apigetbill/apigetbill.dart';
import '../../../utilities/constants.dart';
import '../../../widget/cardcheckbill.dart';
import '../../../widget/cardshoppay.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreen createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
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
                constant.TitleApp_Bar,
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
          padding: EdgeInsets.all(2),
          color: App_Color.Background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8),
                child:
              cardcheckbill("","",""),),
              Container(
                margin: EdgeInsets.only(left: 8,right: 8),
                child:
              Divider(
                color: Colors.grey,
              ),),
              SizedBox(height: 5),
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                    child: Getbillinformation.data_bill.isEmpty
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
                                      const Icon(Icons.done,
                                          color: Colors.green),
                                      const SizedBox(width: 15.0),
                                      Text(
                                        update_SC,
                                        style:
                                            TextStyle(color: App_Color.green),
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
                                    itemCount: Getbillinformation.data_bill.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Shoplistcardpay(
                                        Getbillinformation.data_bill[index].create_date,
                                          Getbillinformation.data_bill[index].original_amount.toString(),
                                          Getbillinformation.data_bill[index].payment.toString()
                                      );
                                    })))),
              ))
            ],
          ),
        ));
  }
}
