import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_formatter/money_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetshopinformation/fn_getshopininformation.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../../funtion_app/apigetbill/apigetbill.dart';
import '../../../provider/manager_credit.dart';
import '../../../utilities/constants.dart';
import '../../../widget/cardshoppay.dart';
import '../shop.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreen createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  @override
  void initState() {
    Hind_pay();
    super.initState();
  }

  void Hind_pay() {
    double temp = double.parse(Provider.of<managen_credit>(context, listen: false).CreditResult());
    double temp2 = temp;
    for (var bill in Getbillinformation.data_bill) {
      if (temp > 0) {
        temp2 = temp;
        temp = temp - (bill.original_amount - bill.payment);
        if (temp <= 0) {
          bill.hint_pay = temp2;
        } else {
          bill.hint_pay = (bill.original_amount - bill.payment);
        }
      } else {
        bill.hint_pay = 0;
      }
    }
  }

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
    MoneyFormatter Formart_money = MoneyFormatter(amount: double.parse(Provider.of<managen_credit>(context, listen: true).CreditResult()));

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              String? token = await prefs.getString("token");
              await getshopinformation.getshopinformation_id(
                  constant.indexcustomer, token!);
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Shoplist(title: constant.TitleApp_Shop)));
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
                  onTap: () {},
                  child: SizedBox(
                    width: 50,
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Container(
                  decoration: BoxDecoration(
                    color: App_Color.Background,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Container(
                      decoration: kBoxDecorationStyle_credit,
                      height: 80.0,
                      // width: MediaQuery.of(context).size.width/1.19,
                      margin: EdgeInsets.only(
                        bottom: 8,
                      ),
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
                          Text("${Formart_money.output.nonSymbol}",
                              style: TextStyle(
                                color: double.parse(Provider.of<managen_credit>(context, listen: true).CreditResult())>0?App_Color.green:Colors.red,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                fontFamily: 'OpenSans',
                              ))
                        ],
                      ))),
              Container(
                color: App_Color.background_textfield,
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(1),
                color: App_Color.Background,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 15),
                    Expanded(
                        child: SingleChildScrollView(
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
                                  height: MediaQuery.of(context).size.height/1.22,
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
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                      controller: _refreshController,
                                      onLoading: _onLoading,
                                      onRefresh: _onRefresh,
                                      child: ListView.builder(
                                          itemCount: Getbillinformation.data_bill.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Shoplistcardpay(
                                              Getbillinformation.data_bill[index].ID,
                                              Getbillinformation.data_bill[index].create_date,
                                              Getbillinformation.data_bill[index].original_amount.toString(),
                                              Getbillinformation.data_bill[index].payment.toString(),
                                              0.0,
                                              Getbillinformation.data_bill[index].hint_pay,
                                              Getbillinformation.data_bill[index].hint_pay > 0 ? true : false,
                                            );
                                          })))),
                    ))
                  ],
                ),
              )
            ])));
  }
}
