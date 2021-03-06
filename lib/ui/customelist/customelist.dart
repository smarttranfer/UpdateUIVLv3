import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/home/fn_getdatacutome.dart';
import 'package:vldebitor/funtion_app/home/home.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../model/sc_datahome/sc_datahome_bill.dart';
import '../../utilities/constants.dart';
import '../../widget/cardcustome.dart';
import '../customeregistry/customeregistry.dart';
import '../shimer_loading/loading.dart';

class Customelist extends StatefulWidget {
  Customelist({Key? key}) : super(key: key);

  @override
  _Customelist createState() => _Customelist();
}

class _Customelist extends State<Customelist> {
  final TextEditingController search = TextEditingController();
  bool checkvalue = false;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final List<Map<String, dynamic>> _allUsers = [];

  List<Map<String, dynamic>> _foundUsers = [];
  String searchString = "";
  String state = "Not Data";
  bool checknull = true;
  bool check_loding_data = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await checkEmty();
      await mapData();
    });
  }

  Future<void> mapData() async {
    for (var customer in constant.ListCustomer_infor_all) {
      _allUsers.add({
        "id": customer.ID,
        "name": customer.Name_Custome,
        "phone": customer.Phone,
        "unallocated": customer.Unallocated,
        "total_shop": customer.Total_shop,
        "total_invoice": customer.Total_invoice,
        "total_invoice_paid": customer.Total_invoice_paid,
        "total_payment": customer.Total_payment,
        "total_liabilities": customer.Total_liabilities
      });
    }
    _foundUsers = _allUsers;
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    results.clear();
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      if (results.isEmpty) {
        results = _allUsers
            .where((phone) => phone["phone"]
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      }
    }
    setState(() {
      _foundUsers = results;
    });
  }

  void _onRefresh() async {
    setState(() {
      constant.ListCustomer_infor_all = [];
    });
    await Future.delayed(Duration(milliseconds: 1000));
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    await fn_DataCustomer.getDataCustomer(token);
    if (home.get_data_Succes == true) {
      _refreshController.refreshCompleted();
      setState(() {
        constant.ListCustomer_infor_all = constant.ListCustomer_infor_all;
      });
    } else {
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    setState(() {
      constant.ListCustomer_infor_all = [];
    });
    await Future.delayed(Duration(milliseconds: 1000));
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    await fn_DataCustomer.getDataCustomer(token);
    if (home.get_data_Succes == true) {
      setState(() {
        constant.ListCustomer_infor_all = constant.ListCustomer_infor_all;
      });
      _refreshController.loadComplete();
    } else {
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
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token").toString();
      await fn_DataCustomer.getDataCustomer(token);
      if (constant.ListCustomer_infor_all.isNotEmpty) {
        setState(() {
          checknull = false;
        });
        return false;
      } else {
        setState(() {
          checknull = true;
        });
        _showWarningMessage("Hi???n t???i kh??ng c?? kh??ch h??ng n??o ???????c t???o.");
        return true;
      }
    } catch (e) {
      return false;
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
            "Kh??ch h??ng",
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
                            child: CustomeregisterScreen()));
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
                  controller: search,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        checkvalue = false;
                      });
                    } else {
                      setState(() {
                        checkvalue = true;
                      });
                    }
                    return _runFilter(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'T??m ki???m',
                    hintStyle: kHintTextStyle,
                    suffixIcon: Visibility(
                        visible: checkvalue,
                        child: IconButton(
                          onPressed: () {
                            search.clear();
                            setState(() {
                              checkvalue = false;
                            });
                            return _runFilter(search.text);
                          },
                          icon: Icon(
                            Icons.clear_rounded,
                            color: App_Color.green,
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: checknull
                    ? Loading()
                    : SingleChildScrollView(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.4,
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
                                    itemCount: _foundUsers.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return customelistcard(
                                          _foundUsers[index]["name"],
                                          _foundUsers[index]["phone"],
                                          _foundUsers[index]["total_shop"]
                                              .toString(),
                                          _foundUsers[index]["total_invoice"]
                                              .toString(),
                                          _foundUsers[index]
                                                  ["total_invoice_paid"]
                                              .toString(),
                                          _foundUsers[index]["total_payment"]
                                              .toString(),
                                          _foundUsers[index]
                                                  ["total_liabilities"]
                                              .toString(),
                                          _foundUsers[index]["unallocated"]
                                              .toString(),
                                          int.parse(
                                            _foundUsers[index]["id"],
                                          ),
                                          false);
                                    })))),
              )
            ],
          ),
        ));
  }
  _showWarningMessage(String message) {
    showCupertinoDialog(
        context: context,
        builder: (context) => Theme(
          data: ThemeData.dark(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: CupertinoAlertDialog(
                title: Text(
                  "Th??ng tin",
                  style: TextStyle(color: Colors.green),
                ),
                content: Text(message),
                actions: [
                  CupertinoDialogAction(
                      child: Text(
                        "????ng ??",
                        style: TextStyle(color: Colors.green),
                      ),
                      onPressed: () async{
                        Navigator.pop(context);
                      }),
                ]),
          ),
        ));
  }
}
