import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetbill/apigetbill.dart';
import 'package:vldebitor/funtion_app/apigetbill/fn_getbill.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../../utilities/constants.dart';
import '../../provider/manager_credit.dart';
import '../home/home.dart';
import 'addbill.dart';
import 'cardpayment.dart';

class PayoneScreen extends StatefulWidget {
  String Name;
  int ID;
  String Total;
  String Paid;
  double Credit;
  PayoneScreen(
      {required this.ID,
      required this.Total,
      required this.Paid,
      required this.Credit,
      required this.Name,
      Key? key})
      : super(key: key);

  @override
  _PayoneScreen createState() => _PayoneScreen();
}

class _PayoneScreen extends State<PayoneScreen> {
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
            onPressed: () async{
              final prefs = await SharedPreferences.getInstance();
              String? token = await prefs.getString("token");
              await getbillinformation.getbill(constant.idshop, token!,1,"asc");
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Billlist()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: App_Color.Background,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            widget.Name,
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
        body: Container(
          padding: EdgeInsets.all(2),
          color: App_Color.Background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: kBoxDecorationStyle_credit,
                  height: 80.0,
                  margin: EdgeInsets.all(
                    10,
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
                      Text("${Provider.of<managen_credit>(context, listen: true).CreditResult()}",
                          style: TextStyle(
                            color: double.parse(Provider.of<managen_credit>(context, listen: true).CreditResult())>0?App_Color.green:Colors.red,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'OpenSans',
                          ))
                    ],
                  )),
              Container(
                color: App_Color.background_textfield,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                  child: Column(
                children: [
                  CardPayment(widget.ID, widget.Total, widget.Paid, constant.credit, (constant.credit > 0 ? true : false)),
                ],
              ))
            ],
          ),
        ));
  }
}
