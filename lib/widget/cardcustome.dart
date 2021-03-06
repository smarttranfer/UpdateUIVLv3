import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetbill/fn_getbill.dart';
import 'package:vldebitor/funtion_app/history/history_creat_credit/gethistory_credit.dart';
import 'package:vldebitor/funtion_app/history/history_creat_credit/history_credit.dart';
import 'package:vldebitor/funtion_app/history/history_customer/gethistory_customer_shop.dart';
import 'package:vldebitor/funtion_app/history/history_customer/history_customer_shop.dart';
import 'package:vldebitor/funtion_app/transation_page/transation_page.dart';
import 'package:vldebitor/ui/createbill/fn_createbill/getshop.dart';
import '../constants/constant_app.dart';
import '../funtion_app/addtocredit/addtocreadit.dart';
import '../funtion_app/addtocredit/fn_addtocredit.dart';
import '../funtion_app/apigetshopinformation/fn_getshopininformation.dart';
import '../funtion_app/apiregistercustomer/delete/deletecustomer.dart';
import '../funtion_app/apiregistercustomer/delete/fn_detelecustomer.dart';
import '../provider/manager_credit.dart';
import '../theme/Color_app.dart';
import '../ui/History/sc_history/sc_history.dart';
import '../ui/addbill/addbill.dart';
import '../ui/createbill/createbill.dart';
import '../ui/createbill/fn_createbill/getshopdata.dart';
import '../ui/creatercredit/createcredit.dart';
import '../ui/edit/edit_custome.dart';
import '../ui/shop/shop.dart';
import '../utilities/constants.dart';

class customelistcard extends StatefulWidget {
  int ID_Custome;
  String name;
  String Phone;
  String NameShop;
  String total_invoice;
  String total_invoice_paid;
  String total_payment;
  String total_liabilities;
  String unallocated;
  bool checkshow;
  customelistcard(this.name, this.Phone, this.NameShop, this.total_invoice, this.total_invoice_paid,this.total_payment,this.total_liabilities,this.unallocated,this.ID_Custome,this.checkshow);

  @override
  State<StatefulWidget> createState() {
    return _ShopregisterScreen();
  }
}

class _ShopregisterScreen extends State<customelistcard> {
  final TextEditingController _money = TextEditingController();
  bool checkdelte = false;

  @override
  void initState() {
    checkdelte = widget.checkshow;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    String money_formart (String money){
      MoneyFormatter total_money = MoneyFormatter(amount: double.parse(money));
      return total_money.output.nonSymbol;
    }
    return Card(
        margin: EdgeInsets.only(top: 0, bottom: 16, left: 8, right: 8),
        color: App_Color.background_search,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        shadowColor: Colors.black54,
        child: Container(
          padding: EdgeInsets.only(left: 0, bottom: 4, top: 0, right: 9),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        barrierColor:Colors.black87,
                        enableDrag: true,
                        context: context,
                        builder: (context) => Container(
                          color: App_Color.Background,
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 5,
                                    width: 30,
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.all(
                                          Radius.circular(40.0),
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 30,),
                                        Icon(
                                          Icons.remove_circle_outline_sharp,
                                          color: Colors.grey,
                                          size: 33.0,
                                        ),
                                        SizedBox(width: 20,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            TextButton(
                                              onPressed: () async {

                                                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: CustomereditScreen(widget.ID_Custome,widget.name,widget.Phone)));

                                              },
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "S???a  ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 17,
                                                      fontFamily: 'OpenSans',
                                                    ),
                                                  ),
                                                  Text(
                                                      "S???a Th??ng tin",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 15,
                                                        fontFamily: 'OpenSans',
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ]),
                              Container(
                                padding: EdgeInsets.only(left: 90),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              // L???ch s??? view
                              Row(children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Icon(
                                  Icons.history,
                                  color: Colors.grey,
                                  size: 33.0,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () async{
                                        constant.check_history_mode = true;
                                        final prefs = await SharedPreferences.getInstance();
                                        String? token = await prefs.getString("token");
                                        await gethistory_customer_shop.gethistory(token!,widget.ID_Custome);
                                        if(constant_history_customer.history_customer_shop_sucess==true){
                                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: HistoryList()));
                                        }else{
                                          _showWarningMessagePay(constant_history_customer.ContentError);
                                        }
                                        // _showWarningMessage("Do you want delete customer ?", DeleteCustomer.DeleteCustomers(widget.ID_Custome, token!));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "L???ch s???",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.none,
                                              fontSize: 17,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                          Text("Xem l???ch s???",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                                fontFamily: 'OpenSans',
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                              Container(
                                padding: EdgeInsets.only(left: 90),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Row(children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Icon(
                                  Icons.hive,
                                  color: Colors.grey,
                                  size: 33.0,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () async{
                                        final prefs = await SharedPreferences.getInstance();
                                        String? token = await prefs.getString("token");
                                        Navigator.pop(context);
                                        _showWarningMessage("B???n mu???n ???n th??ng tin n??y v???i user kh??ng ?", DeleteCustomer.DeleteCustomers(widget.ID_Custome, token!));

                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            checkdelte?"Hi???n th??? l???i":"???n th??n tin ",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.none,
                                              fontSize: 17,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                          Text(checkdelte?"Hi???n th??? l???i th??ng tin v???i user.":"???n th??ng tin n??y v???i user.",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                                fontFamily: 'OpenSans',
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      '...',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    focusColor: App_Color.orange,
                  )
                ],
              ),
              Stack(
                children: [
                  Center(child: Visibility(
                    child:Image.asset("assets/ic_app/ic_delete.png",height: 150,width: 200,),
                    visible: checkdelte,
                    maintainState: true,
                  )),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: [
                              Text(
                                "T??n kh??ch h??ng : ",
                                style: kLabelStyle,
                                textDirection: TextDirection.ltr,
                              ),
                              Text(
                                "${widget.name}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'OpenSans',
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                            ],),

                            SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              Text(
                                "M?? kh??ch h??ng : ",
                                style: kLabelStyle,
                                textDirection: TextDirection.ltr,
                              ),
                              Text(
                                "${widget.ID_Custome}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'OpenSans',
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                            ],),

                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "S??? ??i???n tho???i : ",
                                  style: kLabelStyle,
                                  textDirection: TextDirection.ltr,
                                ),
                                Text(
                                  "${widget.Phone}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'OpenSans',
                                  ),
                                  textDirection: TextDirection.ltr,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              Text(
                                "S??? c???a h??ng : ",
                                style: kLabelStyle,
                                textDirection: TextDirection.ltr,
                              ),
                              Text(
                                "${widget.NameShop}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'OpenSans',
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                            ],),

                            SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              Text(
                                "S??? h??a ????n : ",
                                style: kLabelStyle,
                                textDirection: TextDirection.ltr,
                              ),
                              Text(
                                "${widget.total_invoice_paid}/${widget.total_invoice}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'OpenSans',
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                            ],),

                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "T???ng n??? : ",
                                  style: kLabelStyle,
                                  textDirection: TextDirection.ltr,
                                ),
                                Text(
                                  "${money_formart(widget.total_liabilities)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'OpenSans',
                                  ),
                                  textDirection: TextDirection.ltr,
                                ),

                              ],),
                            SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              Text(
                                "???? tr??? : ",
                                style: kLabelStyle,
                                textDirection: TextDirection.ltr,
                              ),
                              Text(
                                "${money_formart(widget.total_payment)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'OpenSans',
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                            ],),
                            SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              Text(
                                "Ph???i tr??? : ",
                                style: kLabelStyle,
                                textDirection: TextDirection.ltr,
                              ),
                              Text(
                                "${money_formart((double.parse(widget.total_liabilities)-double.parse(widget.total_payment)).toString())}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'OpenSans',
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                            ],),
                            SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              Text(
                                "S??? d?? : ",
                                style: kLabelStyle,
                                textDirection: TextDirection.ltr,
                              ),
                              Text(
                                "${money_formart(double.parse(widget.unallocated).toStringAsFixed(2))}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'OpenSans',
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                            ],)

                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 100,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: Colors.lightBlue, // background
                        textColor: Colors.white, // foreground
                        onPressed: () async{
                          setState(() {
                            constant.indexcustomer = widget.ID_Custome;
                          });
                          final prefs = await SharedPreferences.getInstance();
                          String token = prefs.getString("token").toString();
                          await gethistory_credit.gethistory(widget.ID_Custome, token);
                          if(constant_history.history_credit_sucess == true){
                            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: CreditScreen(ID: widget.ID_Custome,Total: widget.total_liabilities,Paid: widget.total_payment,Credit: double.parse(widget.unallocated),)));
                          }else{
                            _showWarningMessagePay(constant_history.ContentError);
                          }
                        },
                        child: Text("N???p ti???n",style: TextStyle(fontSize: 12),),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        minWidth: 100,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: App_Color.orange, // background
                        textColor: Colors.white, // foreground
                        onPressed: () async{
                          final prefs = await SharedPreferences.getInstance();
                          String? token = await prefs.getString("token");
                          setState(() {
                            constant.TitleApp_Shop = widget.name;
                            constant.indexcustomer = widget.ID_Custome;
                            Provider.of<managen_credit>(context, listen: false).increase(double.parse(widget.unallocated));
                          });
                          constant.indexcustomer = widget.ID_Custome;
                          await getshopinformation.getshopinformation_id(constant.indexcustomer, token!);
                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: Shoplist(title: constant.TitleApp_Shop,)));
                        },
                        child: Text("C???a h??ng",style: TextStyle(fontSize: 12)),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        minWidth: 10,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: App_Color.green, // background
                        textColor: Colors.white, // foreground
                        onPressed: () async{
                          constant.indexcustomer = widget.ID_Custome;
                          final prefs = await SharedPreferences.getInstance();
                          String token = await prefs.getString("token").toString();
                          await getshopinformation_createbills.getshopinformation_id(widget.ID_Custome, token);
                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: CreateBillScreen(Getshopinformation_createbill.data_shop,true)));
                        },
                        child: Text("Th??m h??a ????n",style: TextStyle(fontSize: 12)),
                      )
                    ],
                  ),

                ],
              ),
            ],
          ),
        ));
  }

  _showConfirm(){
    showCupertinoDialog(
        context: context,
        builder: (context) => Theme(
          data: ThemeData.dark(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: CupertinoAlertDialog(
                title: Text(
                  "Add to credit",
                  style: TextStyle(color: Colors.green),
                ),
                content: Card(
                  elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  child:Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    child: TextField(
                      controller: _money,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(5),
                        hintText: 'Input money',
                        hintStyle: kHintTextStyle,
                        fillColor: Colors.transparent
                    ),
                  ),
                )),

                actions: [
                  CupertinoDialogAction(
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.green),
                      ),
                      onPressed: () async{
                        Navigator.pop(context);
                        _showWarningMessagePay("Do you want add to credit ${_money.text}");

                      }),
                  CupertinoDialogAction(
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.pop(context))
                ]),
          ),
        ));
  }

  _showWarningMessagePay(String message) {
    showCupertinoDialog(
        context: context,
        builder: (context) => Theme(
          data: ThemeData.dark(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: CupertinoAlertDialog(
                title: Text(
                  "Warning",
                  style: TextStyle(color: Colors.red),
                ),
                content: Text(message),
                actions: [
                  CupertinoDialogAction(
                      child: Text(
                        "Cancle",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.pop(context))
                ]),
          ),
        ));
  }

  _showWarningMessage(String message,Future f) {
    showCupertinoDialog(
        context: context,
        builder: (context) => Theme(
              data: ThemeData.dark(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: CupertinoAlertDialog(
                    title: Text(
                      "Warning",
                      style: TextStyle(color: Colors.red),
                    ),
                    content: Text(message),
                    actions: [
                      CupertinoDialogAction(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async{
                            setState(() {
                              checkdelte =! checkdelte;
                            });
                           await f;
                           if(Deletecustomer.Delete_Customer_Succes==true){
                             Fluttertoast.showToast(
                                 msg: "Delete customer successfully",
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.BOTTOM,
                                 timeInSecForIosWeb: 5,
                                 backgroundColor: App_Color.background_textfield,
                                 textColor: Colors.white,
                                 fontSize: 16.0
                             );
                             Navigator.pop(context);
                           }else{
                             Fluttertoast.showToast(
                                 msg: Deletecustomer.ContentError,
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.BOTTOM,
                                 timeInSecForIosWeb: 5,
                                 backgroundColor: App_Color.background_textfield,
                                 textColor: Colors.white,
                                 fontSize: 16.0
                             );
                           }
                           Navigator.pop(context);
                          }),
                      CupertinoDialogAction(
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => Navigator.pop(context))
                    ]),
              ),
            ));
  }
}
