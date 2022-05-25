import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/home/fn_getdatacutome.dart';
import 'package:vldebitor/funtion_app/home/home.dart';
import 'package:vldebitor/funtion_app/transation_page/transation_page.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../model/sc_datahome/sc_datahome_bill.dart';
import '../../utilities/constants.dart';
import '../../widget/cardcustome.dart';
import '../customeregistry/customeregistry.dart';

class Customelist extends StatefulWidget {
  Customelist({Key? key}) : super(key: key);

  @override
  _Customelist createState() => _Customelist();
}

class _Customelist extends State<Customelist> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _foundUsers = [];
  String searchString = "";
  String state = "Not Data";
  bool checknull = true;
  bool check_loding_data = true;


  @override
  void didChangeDependencies() async{
    await checkEmty();
    super.didChangeDependencies();
  }


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
      constant.ListCustomer_infor_all=[];
    });
    await Future.delayed(Duration(milliseconds: 1000));
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    await fn_DataCustomer.getDataCustomer(token);
    if(home.get_data_Succes==true){
      _refreshController.refreshCompleted();
      setState(() {
        constant.ListCustomer_infor_all=constant.ListCustomer_infor_all;
      });
    }else{
      _refreshController.refreshFailed();
    }

  }

  void _onLoading() async {
    setState(() {
      constant.ListCustomer_infor_all=[];
    });
    await Future.delayed(Duration(milliseconds: 1000));
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    await fn_DataCustomer.getDataCustomer(token);
    if(home.get_data_Succes==true){
      setState(() {
        constant.ListCustomer_infor_all=constant.ListCustomer_infor_all;
      });
      _refreshController.loadComplete();
    }else{
      _refreshController.loadFailed();
    }
  }

  String List_shop(List<sc_datahome_bill> list_shop_bill) {
    String shops = "";
    for (var shop in list_shop_bill) {
      shops += shop.Name.toString();
    }
    return shops;
  }

  Future<bool> checkEmty() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    await fn_DataCustomer.getDataCustomer(token);
    if(constant.ListCustomer_infor_all.isNotEmpty){
      setState(() {
        checknull = false;
      });
      return false;
    }else {
      setState(() {
        checknull = true;
      });
      return true;
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
            "Khách hàng",
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
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: CustomeregisterScreen()));
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
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                    child: checknull
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedTextKit(
                                animatedTexts: [
                                  WavyAnimatedText(state,
                                      textStyle:
                                          TextStyle(color: App_Color.green)),
                                ],
                                isRepeatingAnimation: true,
                              ),
                              Center(
                                  child: IconButton(
                                      onPressed: () async{
                                        setState(() {
                                          state = "Get Data";
                                        });
                                        final prefs = await SharedPreferences.getInstance();
                                        String token = prefs.getString("token").toString();
                                        await fn_DataCustomer.getDataCustomer(token);
                                        if(constant.ListCustomer_infor_all.isNotEmpty){
                                          checkEmty();
                                        }
                                      },
                                      icon: Icon(
                                        Icons.refresh,
                                        color: App_Color.green,
                                      )))
                            ],
                          ))
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/1.4,
                            child: SmartRefresher(
                                physics: const BouncingScrollPhysics(),
                                enablePullDown: true,
                                enablePullUp: false,
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
                                    itemCount: constant.ListCustomer_infor_all.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return customelistcard(
                                          constant.ListCustomer_infor_all[index].Name_Custome,
                                          constant.ListCustomer_infor_all[index].Phone,
                                          constant.ListCustomer_infor_all[index].Total_shop.toString(),
                                          constant.ListCustomer_infor_all[index].Total_invoice.toString(),
                                          constant.ListCustomer_infor_all[index].Total_invoice_paid.toString(),
                                          constant.ListCustomer_infor_all[index].Total_payment.toString(),
                                          constant.ListCustomer_infor_all[index].Total_liabilities.toString(),
                                          constant.ListCustomer_infor_all[index].Unallocated.toString(),
                                          int.parse(constant.ListCustomer_infor_all[index].ID),
                                          );
                                    })))),
              ))
            ],
          ),
        ));
  }
}
