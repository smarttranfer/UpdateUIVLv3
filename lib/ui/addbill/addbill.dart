import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_formatter/money_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetbill/apigetbill.dart';
import 'package:vldebitor/funtion_app/apigetshopinformation/fn_getshopininformation.dart';
import 'package:vldebitor/theme/Color_app.dart';
import 'package:vldebitor/ui/creatercredit/createbillmore.dart';
import '../../provider/manager_credit.dart';
import '../../utilities/constants.dart';
import '../../widget/cardbill.dart';
import '../createbill/fn_createbill/getshopdata.dart';
import '../shop/shop.dart';


class Billlist extends StatefulWidget {
  Billlist({Key? key,}) : super(key: key);

  @override
  _Billlist createState() => _Billlist();
}

class _Billlist extends State<Billlist> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _foundUsers = [];
  String searchString = "";
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
        results = _allUsers.where((user) => user["id"].toString().toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      }
    }
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  void initState(){
    mapData();
  }

  Future<void> mapData()async {
    for (var bill in  Getbillinformation.data_bill) {
      _allUsers.add({
        "id": bill.ID,
        "name": bill.Name,
        "payment": bill.payment,
        "content": bill.content,
        "status": bill.status,
        "original_amount": bill.original_amount,
        "user_id": bill.user_id,
        "shop_id": bill.shop_id,
        "transaction_status": bill.transaction_status,
        "create_date": bill.create_date
      });
    }
    _foundUsers = _allUsers;
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
            onPressed: () async{
              final prefs = await SharedPreferences.getInstance();
              String? token = await prefs.getString("token");
              await getshopinformation.getshopinformation_id( constant.indexcustomer, token!);
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: Shoplist(title: constant.TitleApp_Shop,)));
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
                    print(Getshopinformation_createbill.data_shop);
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: CreateBillScreenMore(Getshopinformation_createbill.data_shop,constant.index_bill,Billlist())));
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
                          Text("${Formart_money.output.nonSymbol}",style: TextStyle(
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
                    child: constant.ListCustomer_infor_all.isEmpty
                        ? Center(
                            child: Text(
                              "Not data",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/1.55,
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
                                        update_SC, style: TextStyle(color: App_Color.green),
                                      )
                                    ],
                                  ),
                                  failed: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Icon(Icons.error_outline, color: Colors.red),
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return cardbill(
                                        _foundUsers[index]["name"],
                                        _foundUsers[index]["id"].toString(),
                                        _foundUsers[index]["original_amount"].toString(),
                                        _foundUsers[index]["payment"].toString(),
                                        (_foundUsers[index]["original_amount"]-_foundUsers[index]["payment"]).toString(),
                                        _foundUsers[index]["create_date"].toString(),
                                      );
                                    })))),
              ))
            ],
          ),
        ));
  }

}
