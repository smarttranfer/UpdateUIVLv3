import 'dart:ui';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetbill/fn_getbill.dart';
import 'package:vldebitor/funtion_app/apigetshopinformation/fn_getshopininformation.dart';
import 'package:vldebitor/funtion_app/apipayment/Payment.dart';
import 'package:vldebitor/funtion_app/apipayment/fn_payment.dart';
import 'package:vldebitor/funtion_app/transation_page/transation_page.dart';
import 'package:vldebitor/ui/createbill/fn_createbill/getshop.dart';
import '../provider/manager_credit.dart';
import '../theme/Color_app.dart';
import '../ui/shop/detail/detail.dart';
import '../ui/shop/shop.dart';
import '../utilities/constants.dart';

class Shoplistcardpay extends StatefulWidget {
  int ID;
  String Date;
  String Total;
  String Paid;
  double Credit;
  double suggest;
  bool checkactive;

  Shoplistcardpay(this.ID, this.Date, this.Total, this.Paid, this.Credit,
      this.suggest, this.checkactive);

  @override
  State<StatefulWidget> createState() {
    return _Shoplistcardpay();
  }
}

class _Shoplistcardpay extends State<Shoplistcardpay> {
  final TextEditingController _money = TextEditingController();
  bool checkdone = false;
  bool checkenable = false;
  bool checkactive = true;
  late double credit = 0.0;
  late double total = 0.0;
  late double paid = 0.0;
  late double mustpay = 0.0;
  late double suggest = 0.0;
  String status = '0.0';

  @override
  void initState() {
    _money..text = "${widget.suggest}";
    suggest = widget.suggest;
    checkdone = widget.checkactive;
    total = double.parse(widget.Total);
    paid = double.parse(widget.Paid);
    mustpay = double.parse(widget.Total) - double.parse(widget.Paid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formart_money(String money) {
      MoneyFormatter money_format = MoneyFormatter(amount: double.parse(money));
      return money_format.output.nonSymbol;
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
          padding: EdgeInsets.only(left: 0, bottom: 4, top: 12, right: 9),
          child: Column(
            children: [
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
                          "Ngày tạo : ${widget.Date}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Số nợ : ${formart_money(total.toString())}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Đã trả: ${formart_money(paid.toString())}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Phải trả: ${formart_money(mustpay.toString())}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Thanh toán:",
                              style: kLabelStyle,
                              textDirection: TextDirection.ltr,
                            ),
                            SizedBox(width: 5),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationMoneyStyle,
                              width: MediaQuery.of(context).size.width / 1.56,
                              height: 30,
                              child: TextField(
                                inputFormatters: <TextInputFormatter>[
                                  CurrencyTextInputFormatter(
                                    locale: 'EN',
                                    decimalDigits: 2,
                                    symbol: '',
                                  ),
                                  // formatter,
                                ],
                                readOnly: checkenable,
                                controller: _money,
                                keyboardType: TextInputType.number,
                                onChanged: (e) {
                                  try {
                                    if ((double.parse(e.toString().replaceAll(",", "")) > double.parse(Provider.of<managen_credit>(context, listen: false).CreditResult()))) {
                                      setState(() {
                                        suggest =double.parse(e);
                                      });
                                      Fluttertoast.showToast(
                                          msg: "Số tiêng không đủ để thực hiện",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else if (double.parse(e.toString().replaceAll(",", "")) > mustpay) {
                                      setState(() {
                                        suggest =double.parse(e);
                                      });
                                      Fluttertoast.showToast(
                                          msg: "Số tiền bạn nhập vượt quá số tiền phải trả",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }else{
                                      setState(() {
                                        suggest =double.parse(e);
                                      });
                                    }
                                  } catch (e) {}
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(bottom: 14, left: 5),
                                  hintText: status,
                                  hintStyle: kHintTextStyle,
                                ),
                              ),
                            )
                          ],
                        )
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
                        minWidth: 10,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: App_Color.orange, // background
                        textColor: Colors.white, // foreground
                        onPressed: () {
                          transation_page.transation_router(DetailScreen(), 1);
                        },
                        child: Text("Lịch sử"),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        disabledColor: App_Color.green.withOpacity(0.2),
                        minWidth: 70,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: App_Color.green, // background
                        textColor: Colors.white, // foreground
                        onPressed: ((suggest <= double.parse(Provider.of<managen_credit>(context, listen: false).CreditResult()))&&suggest>0)
                            ? () async {
                                final prefs = await SharedPreferences.getInstance();
                                String? token = await prefs.getString("token");
                                await fn_payment.Payment(double.parse(_money.text.replaceAll(",", "")), constant.indexcustomer, token!, widget.ID);
                                if (payments.Create_payment_Succes == true) {
                                  Provider.of<managen_credit>(context, listen: false).decrease(double.parse(_money.text.replaceAll(",", "")));
                                  if (mustpay > 0 && double.parse(Provider.of<managen_credit>(context, listen: false).CreditResult()) > 0) {
                                    setState(() {
                                      paid = paid + double.parse(_money.text.toString().replaceAll(",", ""));
                                      credit = credit -double.parse(_money.text.toString().replaceAll(",", ""));
                                      mustpay = mustpay - double.parse(_money.text.toString().replaceAll(",", ""));
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Thanh toán thành công.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if(mustpay == 0) {
                                    setState(() {
                                      suggest=0.0;
                                    });
                                    _money.clear();
                                  } else{
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: payments.ContentError,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              }
                            : null,
                        child: Text("Thanh toán"),
                      )
                    ],
                  )
                ],
              ),
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
                      "Cảnh báo",
                      style: TextStyle(color: Colors.red),
                    ),
                    content: Text(message),
                    actions: [
                      CupertinoDialogAction(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () => Navigator.pop(context)),
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
