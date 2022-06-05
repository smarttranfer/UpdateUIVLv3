import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetshopinformation/delete/fn_delete.dart';
import 'package:vldebitor/funtion_app/history/history_shop/gethistory_shop.dart';
import 'package:vldebitor/funtion_app/history/history_shop/history_shop.dart';
import 'package:vldebitor/funtion_app/transation_page/transation_page.dart';
import 'package:vldebitor/ui/createbill/fn_createbill/getshop.dart';
import '../funtion_app/apigetbill/apigetbill.dart';
import '../funtion_app/apigetbill/fn_getbill.dart';
import '../funtion_app/apiregistercustomer/delete/fn_detelecustomer.dart';
import '../provider/manager_credit.dart';
import '../theme/Color_app.dart';
import '../ui/History/sc_history/sc_history.dart';
import '../ui/addbill/addbill.dart';
import '../ui/createbill/fn_createbill/getshopdata.dart';
import '../ui/creatercredit/createbillmore.dart';
import '../ui/edit/edit_shop.dart';
import '../ui/shop/detail/detail.dart';
import '../ui/shop/shop.dart';
import '../utilities/constants.dart';

class Shoplistcard extends StatefulWidget {
  int id;
  String name;
  String address;
  String building_number;
  String street_name;
  String post_code;
  String total_invoice_paid;
  String total_invoice;
  String total_payment;
  String total_liabilities;
  String date_create;
  int index_bill;

  Shoplistcard(
      this.index_bill,
      this.id,
      this.name,
      this.address,
      this.building_number,
      this.street_name,
      this.post_code,
      this.total_invoice_paid,
      this.total_invoice,
      this.total_payment,
      this.total_liabilities,
      this.date_create);

  @override
  State<StatefulWidget> createState() {
    return _Shoplistcard();
  }
}

class _Shoplistcard extends State<Shoplistcard> {

  @override
  Widget build(BuildContext context) {
    MoneyFormatter total_liabilities = MoneyFormatter(amount: double.parse(widget.total_liabilities));
    MoneyFormatter total_payment = MoneyFormatter(amount: double.parse(widget.total_payment));
    MoneyFormatter mustpay = MoneyFormatter(amount: double.parse(widget.total_liabilities) - double.parse(widget.total_payment));
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
                                              onPressed: () {

                                                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: ShopEditScreen(widget.id,widget.name,widget.building_number,widget.street_name,widget.post_code)));
                                              },
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Sửa  ",
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
                                                      "Sửa thông tin",
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
                              // Lịch sử view
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
                                        constant.check_history_mode = false;
                                        final prefs = await SharedPreferences.getInstance();
                                        String? token = await prefs.getString("token");
                                        await gethistory_shop.gethistory(token!,widget.id);
                                        if(constant_history_shop.history_customer_shop_sucess==true){
                                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: HistoryList()));
                                        }else{
                                          _showMessage(constant_history_shop.ContentError);
                                        }
                                        // _showWarningMessage("Do you want delete customer ?", DeleteCustomer.DeleteCustomers(widget.ID_Custome, token!));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Lịch sử",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.none,
                                              fontSize: 17,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                          Text("Xem lịch sử",
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
                                        _showWarningMessage("Do you want delete customer ?", DeleteCustomer.DeleteCustomers(constant.indexcustomer, token!));
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
                        Text(
                          "Tên cửa hàng: ${widget.name}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Mã cửa hàng: ${widget.id}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Địa chỉ: ${widget.address}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Hóa đơn: ${widget.total_invoice_paid}/${widget.total_invoice}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Tổng nợ: ${total_liabilities.output.nonSymbol}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Đã trả: ${total_payment.output.nonSymbol}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Phải trả: ${mustpay.output.nonSymbol}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Ngày tạo : ${widget.date_create}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
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
                        minWidth: 70,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: Colors.blue, // background
                        textColor: Colors.white, // foreground
                        onPressed: () async {
                          constant.TitleApp_Bar = widget.name;
                          final prefs = await SharedPreferences.getInstance();
                          String? token = await prefs.getString("token");
                          await getbillinformation.getbill(widget.id, token!,-1,"asc");
                          if (Getbillinformation.GetbillinformationSucces == true) {
                            double.parse(Provider.of<managen_credit>(context, listen: false).CreditResult()) > 0
                                ? Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: DetailScreen()))
                                : _showWarningMessages("Số dư hiện tại của khách hàng đang là 0. Bạn cần yêu cầu khách hàng nạp tiền để thực hiện thanh toán");
                          } else {
                            _showMessage(Getbillinformation.ContentError);
                          }
                        },
                        child: Text("Thanh toán"),
                      )
                    ],
                  )
                  ,
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
                        onPressed: () async {
                          constant.TitleApp_Bar = widget.name;
                          final prefs = await SharedPreferences.getInstance();
                          String? token = await prefs.getString("token");
                          await getbillinformation.getbill(widget.id, token!,1,"desc");
                          constant.index_bill = widget.index_bill;
                          constant.idshop = widget.id;
                          if (Getbillinformation.GetbillinformationSucces == true) {
                            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Billlist()));
                          } else {
                            _showMessage(Getbillinformation.ContentError);
                          }
                        },
                        child: Text("Hoá đơn"),
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
                        color: Colors.green, // background
                        textColor: Colors.white, // foreground
                        onPressed: () async {
                          constant.TitleApp_Bar = widget.name;
                          final prefs = await SharedPreferences.getInstance();
                          String? token = await prefs.getString("token");
                          await getbillinformation.getbill(widget.id, token!,1,"asc");
                          await getshopinformation_createbills.getshopinformation_id(constant.indexcustomer, token);
                          constant.index_bill = widget.index_bill;
                          if (Getbillinformation.GetbillinformationSucces == true) {
                            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: CreateBillScreenMore(Getshopinformation_createbill.data_shop,constant.index_bill,Shoplist(title: constant.TitleApp_Shop,))));
                          } else {
                            _showMessage(Getbillinformation.ContentError);
                          }
                        },
                        child: Text("Tạo hóa đơn"),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }

  _showMessage(String message) {
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
                          onPressed: () {
                            Navigator.of(context).pop();
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

  _showWarningMessage(String message, Future funtions) {
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
                          onPressed: () async {
                            await funtions;
                            Navigator.of(context).pop();
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

  _showWarningMessages(String message) {
    showCupertinoDialog(
        context: context,
        builder: (context) => Theme(
              data: ThemeData.dark(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: CupertinoAlertDialog(content: Text(message), actions: [
                  CupertinoDialogAction(
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      }),
                ]),
              ),
            ));
  }
}
