import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../../funtion_app/apigetbill/apigetbill.dart';
import '../../../utilities/constants.dart';
import '../../../widget/cardshoppay.dart';
import '../home/home.dart';
import 'cardcredit.dart';

class CreditScreen extends StatefulWidget {
  int ID;
  String Total;
  String Paid;
  double Credit;
  CreditScreen(
      {required this.ID,
      required this.Total,
      required this.Paid,
      required this.Credit,
      Key? key})
      : super(key: key);

  @override
  _CreditScreen createState() => _CreditScreen();
}

class _CreditScreen extends State<CreditScreen> {
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
            "Nạp Tiền",
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
                  onTap: () {},
                  child: SizedBox(
                    width: 50,
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(2),
          color: App_Color.Background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Container(
                  child: Column(
                children: [
                  CardCredit(
                      widget.ID, widget.Total, widget.Paid, widget.Credit),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "History",
                      style: kLabelStyleHistory,
                      textDirection: TextDirection.ltr,
                    )
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                        child: Getbillinformation.data_bill.isEmpty
                            ? Center(
                                child: AnimatedTextKit(
                                animatedTexts: [
                                  WavyAnimatedText("Not Data",
                                      textStyle:
                                          TextStyle(color: App_Color.green)),
                                ],
                                isRepeatingAnimation: true,
                              ))
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3,
                                child: SmartRefresher(
                                    physics: const BouncingScrollPhysics(),
                                    enablePullDown: true,
                                    enablePullUp: true,
                                    header: WaterDropHeader(
                                      waterDropColor: App_Color.green,
                                      complete: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Icon(Icons.done,
                                              color: Colors.green),
                                          const SizedBox(width: 15.0),
                                          Text(
                                            update_SC,
                                            style: TextStyle(
                                                color: App_Color.green),
                                          )
                                        ],
                                      ),
                                      failed: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        itemCount: 0,
                                        // Getbillinformation.data_bill.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Shoplistcardpay(
                                              Getbillinformation.data_bill[index].ID,
                                              Getbillinformation.data_bill[index].create_date,
                                              Getbillinformation.data_bill[index].original_amount.toString(),
                                              Getbillinformation.data_bill[index].payment.toString(),
                                              0.0,
                                              constant.credit > 0 ? ((constant.credit - (Getbillinformation.data_bill[index].original_amount - Getbillinformation.data_bill[index].payment)) > 0 ? double.parse((Getbillinformation.data_bill[index].original_amount - Getbillinformation.data_bill[index].payment).toStringAsFixed(2)) : 0.0): 0.0,
                                              (constant.credit > 0 ? ((constant.credit - (Getbillinformation.data_bill[index].original_amount - Getbillinformation.data_bill[index].payment)) > 0 ? double.parse((Getbillinformation.data_bill[index].original_amount - Getbillinformation.data_bill[index].payment).toStringAsFixed(2)) : 0.0): 0.0)>0.0 ? true:false
                                          );

                                        })))),
                  )
                ],
              ))
            ],
          ),
        )));
  }
}
