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
import 'package:vldebitor/theme/Color_app.dart';
import '../../../funtion_app/apigetbill/apigetbill.dart';
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

  void Hind_pay(){
    double temp = constant.credit;
    for(var bill in  Getbillinformation.data_bill){

      if(temp>0){
        temp = constant.credit - (bill.original_amount - bill.payment);
        if(temp<=0){
          bill.hint_pay=constant.credit;
        }else{
          bill.hint_pay = (bill.original_amount - bill.payment);
        }
      }else{
        bill.hint_pay = 0;
      }
    }
  }

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
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
              await getshopinformation.getshopinformation_id( constant.indexcustomer, token!);
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: Shoplist(title: constant.TitleApp_Shop)));
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
        body: Container(
          padding: EdgeInsets.all(2),
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
                                    itemCount:
                                        Getbillinformation.data_bill.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Shoplistcardpay(
                                          Getbillinformation.data_bill[index].ID,
                                          Getbillinformation.data_bill[index].create_date,
                                          Getbillinformation.data_bill[index].original_amount.toString(),
                                          Getbillinformation.data_bill[index].payment.toString(),
                                          0.0,
                                          Getbillinformation.data_bill[index].hint_pay,
                                          Getbillinformation.data_bill[index].hint_pay>0? true:false
                                      );
                                    })))),
              ))
            ],
          ),
        ));
  }
}
