import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetbill/fn_getbill.dart';
import 'package:vldebitor/funtion_app/transation_page/transation_page.dart';
import 'package:vldebitor/ui/createbill/fn_createbill/getshop.dart';
import '../constants/constant_app.dart';
import '../funtion_app/addtocredit/addtocreadit.dart';
import '../funtion_app/addtocredit/fn_addtocredit.dart';
import '../funtion_app/apigetshopinformation/fn_getshopininformation.dart';
import '../funtion_app/apiregistercustomer/delete/deletecustomer.dart';
import '../funtion_app/apiregistercustomer/delete/fn_detelecustomer.dart';
import '../theme/Color_app.dart';
import '../ui/addbill/addbill.dart';
import '../ui/createbill/createbill.dart';
import '../ui/createbill/fn_createbill/getshopdata.dart';
import '../ui/creatercredit/createcredit.dart';
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

  customelistcard(this.name, this.Phone, this.NameShop, this.total_invoice, this.total_invoice_paid,this.total_payment,this.total_liabilities,this.unallocated,this.ID_Custome);

  @override
  State<StatefulWidget> createState() {
    return _ShopregisterScreen();
  }
}

class _ShopregisterScreen extends State<customelistcard> {
  final TextEditingController _money = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                        context: context,
                        builder: (context) => Container(
                          color: App_Color.Background,
                          height: MediaQuery.of(context).size.height / 4,
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
                                              onPressed: () {},
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Edit  ",
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
                                                      "Edit information of shop",
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
                              Row(children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Icon(
                                  Icons.recycling_outlined,
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
                                        _showWarningMessage("Do you want delete customer ?", DeleteCustomer.DeleteCustomers(widget.ID_Custome, token!));


                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.none,
                                              fontSize: 17,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                          Text("Delete Customer",
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
                              ])
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
                            "Tên khách hàng : ",
                            style: kLabelStyle,
                            textDirection: TextDirection.ltr,
                          ),
                          Text(
                            "${widget.name}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                              "Số điện thoại : ",
                              style: kLabelStyle,
                              textDirection: TextDirection.ltr,
                            ),
                            Text(
                              "${widget.Phone}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
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
                            "Số cửa hàng : ",
                            style: kLabelStyle,
                            textDirection: TextDirection.ltr,
                          ),
                          Text(
                            "${widget.NameShop}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                            "Số hóa đơn : ",
                            style: kLabelStyle,
                            textDirection: TextDirection.ltr,
                          ),
                          Text(
                            "${widget.total_invoice_paid}/${widget.total_invoice}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                            "Tổng nợ : ",
                            style: kLabelStyle,
                            textDirection: TextDirection.ltr,
                          ),
                          Text(
                            "${widget.total_liabilities}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                            "Đã trả : ",
                            style: kLabelStyle,
                            textDirection: TextDirection.ltr,
                          ),
                          Text(
                            "${widget.total_payment}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                            "Phải trả : ",
                            style: kLabelStyle,
                            textDirection: TextDirection.ltr,
                          ),
                          Text(
                            "${double.parse(widget.total_liabilities)-double.parse(widget.total_payment)}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                            "Số dư : ",
                            style: kLabelStyle,
                            textDirection: TextDirection.ltr,
                          ),
                          Text(
                            "${widget.unallocated}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                          _showConfirm();
                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: CreditScreen(ID: widget.ID_Custome,Total: widget.total_liabilities,Paid: widget.total_payment,Credit: double.parse(widget.unallocated),)));

                        },
                        child: Text("Nap tiền",style: TextStyle(fontSize: 12),),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
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
                            constant.credit = double.parse(widget.unallocated);
                          });
                          await getshopinformation.getshopinformation_id( widget.ID_Custome, token!);
                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: Shoplist(title: constant.TitleApp_Shop,)));
                        },
                        child: Text("Của hàng",style: TextStyle(fontSize: 12)),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 100,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: App_Color.green, // background
                        textColor: Colors.white, // foreground
                        onPressed: () async{
                          final prefs = await SharedPreferences.getInstance();
                          String? token = await prefs.getString("token");
                          constant.indexcustomer = widget.ID_Custome;
                          await getbillinformation.getbill(widget.ID_Custome, token!);
                          await getshopinformation_createbills.getshopinformation_id(widget.ID_Custome, token);

                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: CreateBillScreen(Getshopinformation_createbill.data_shop)));
                        },
                        child: Text("Thêm hóa đơn",style: TextStyle(fontSize: 12)),
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
                        "Yes",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () async{
                        final prefs = await SharedPreferences.getInstance();
                        String? token = await prefs.getString("token");
                        await fn_AddToCredit.AddtoCredits(double.parse(_money.text), widget.ID_Custome, token!);
                        if(AddCredit_check.AddCredit_Succes==true){
                          Fluttertoast.showToast(
                              msg: "Add to successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: App_Color.background_textfield,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }else{
                          Fluttertoast.showToast(
                              msg: AddCredit_check.ContentError,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
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
                           await f;
                           if(Deletecustomer.Delete_Customer_Succes==true){
                             Fluttertoast.showToast(
                                 msg: "Delete customer successfully",
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.CENTER,
                                 timeInSecForIosWeb: 1,
                                 backgroundColor: App_Color.background_textfield,
                                 textColor: Colors.white,
                                 fontSize: 16.0
                             );
                             Navigator.pop(context);
                           }else{
                             Fluttertoast.showToast(
                                 msg: Deletecustomer.ContentError,
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.CENTER,
                                 timeInSecForIosWeb: 1,
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
