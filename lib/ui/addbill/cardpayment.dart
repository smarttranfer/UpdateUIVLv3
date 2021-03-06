import 'dart:ui';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/addtocredit/addtocreadit.dart';
import 'package:vldebitor/funtion_app/addtocredit/fn_addtocredit.dart';
import 'package:vldebitor/funtion_app/apigetbill/fn_getbill.dart';
import 'package:vldebitor/funtion_app/apipayment/Payment.dart';
import 'package:vldebitor/funtion_app/apipayment/fn_payment.dart';
import 'package:vldebitor/funtion_app/history/history_bill_many/history_bil.dart';
import 'package:vldebitor/funtion_app/history/history_bill_many/history_bill_many.dart';
import '../../provider/manager_credit.dart';
import '../../theme/Color_app.dart';
import '../../utilities/constants.dart';
import '../History/sc_history_bill_many/sc_history_bill_many.dart';
import 'addbill.dart';

class CardPayment extends StatefulWidget {
  int ID;
  String Total;
  String Paid;
  double Credit;
  bool check;
  CardPayment(this.ID, this.Total, this.Paid, this.Credit, this.check);

  @override
  State<StatefulWidget> createState() {
    return _CardPayment();
  }
}

class _CardPayment extends State<CardPayment> {
  final TextEditingController _money = TextEditingController();
  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter();
  late bool checkactive = false;
  late double credit = 0.0;
  late double total = 0.0;
  late double paid = 0.0;
  late double mustpay = 0.0;
  @override
  void initState() {
    credit = widget.Credit;
    total = double.parse(widget.Total);
    checkactive = widget.check;
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
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "S??? n???: ${formart_money(total.toString())}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text(
                          "???? tr???: ${formart_money(paid.toString())}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text(
                          "Ph???i tr???: ${formart_money(mustpay.toString())}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Thanh to??n:",
                              style: kLabelStyle,
                              textDirection: TextDirection.ltr,
                            ),
                            SizedBox(width: 5),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationMoneyStyle,
                              width: MediaQuery.of(context).size.width / 1.6,
                              height: 30,
                              child: TextField(
                                inputFormatters: <TextInputFormatter>[
                                  CurrencyTextInputFormatter(
                                    locale: 'EN',
                                    decimalDigits: 2,
                                    symbol: '',
                                  ),
                                ],
                                onChanged: (e) {
                                  try {
                                    if ((double.parse(
                                            e.toString().replaceAll(",", "")) >
                                        double.parse(
                                            Provider.of<managen_credit>(context,
                                                    listen: false)
                                                .CreditResult()))) {
                                      setState(() {
                                        checkactive = false;
                                      });
                                      Fluttertoast.showToast(
                                          msg: "S??? ti???n kh??ng ????? ????? th???c hi???n",
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 100,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      if (double.parse(e
                                              .toString()
                                              .replaceAll(",", "")) >
                                          mustpay) {
                                        setState(() {
                                          checkactive = false;
                                        });
                                        Fluttertoast.showToast(
                                            msg:
                                                "S??? ti???n b???n nh???p v?????t qu?? s??? ti???n ph???i tr???",
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 100,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else {
                                        setState(() {
                                          checkactive = widget.check;
                                        });
                                      }
                                    }
                                  } catch (e) {}
                                },
                                controller: _money,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(bottom: 14, left: 5),
                                  hintText: '0.0',
                                  hintStyle: kHintTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Center(
                          child: MaterialButton(
                            disabledColor: App_Color.green.withOpacity(0.2),
                            minWidth: 70,
                            height: 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: App_Color.green, // background
                            textColor: Colors.white, // foreground
                            onPressed: checkactive
                                ? () async {
                                    if (_money.text.isNotEmpty) {
                                      final prefs =
                                      _showErrorMessage("B???n c?? mu???n thanh to??n s??? ti???n ${_money.text} cho h??a ????n n??y kh??ng.?" );
                                      // await fn_payment.Payment(double.parse(_money.text.replaceAll(",", "")), constant.indexcustomer, token, widget.ID);

                                    } else {
                                      _showErrorMessage(
                                          "B???n v???n ch??a nh???p s??? ti???n ph???i tr???");
                                    }
                                  }
                                : null,
                            child: Text(" Thanh to??n "),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _showTopFlash(
      {FlashBehavior style = FlashBehavior.floating,
      required String title,
      required String messager}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 5),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          borderRadius: BorderRadius.circular(20.0),
          margin: EdgeInsets.all(10),
          controller: controller,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          boxShadows: [BoxShadow(blurRadius: 4)],
          barrierBlur: 3.0,
          behavior: style,
          position: FlashPosition.top,
          child: FlashBar(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(messager),
            // showProgressIndicator: true,
            primaryAction: TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                String? token = await prefs.getString("token");
                await gethistory_bill_many.gethistory(widget.ID, token!);
                if (constant_history_billpayment.listhistory_billpayment_sucess == true) {
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: HistoryList_bill()));
                }
              },
              child: Text('More', style: TextStyle(color: App_Color.green)),
            ),
          ),
        );
      },
    );
  }

  _showErrorMessage(String messenger) {
    showCupertinoDialog(
        context: context,
        builder: (context) => Theme(
              data: ThemeData.dark(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: CupertinoAlertDialog(
                    title: Text(
                      "Th??ng tin",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Text("${messenger}"),
                    actions: [
                      CupertinoDialogAction(
                          child: Text(
                            "yes",
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            String? token = await prefs.getString("token").toString();
                            await fn_payment.Payment(double.parse(_money.text.replaceAll(",", "")), constant.indexcustomer, token, widget.ID);
                            if (payments.Create_payment_Succes == true) {
                              Provider.of<managen_credit>(context, listen: false).decrease(double.parse(_money.text.replaceAll(",", "")));
                              setState(() {
                                paid = paid + double.parse(_money.text.replaceAll(",", ""));
                                credit = credit - double.parse(_money.text.replaceAll(",", ""));
                                mustpay = mustpay - double.parse(_money.text.replaceAll(",", ""));
                              });
                              if (mustpay > 0 &&
                                  double.parse(
                                      Provider.of<managen_credit>(
                                          context,
                                          listen: false)
                                          .CreditResult()) >
                                      0) {
                                _showTopFlash(
                                    messager:
                                    "H??a ????n ${constant.TitleApp_Bill} ???? thanh to??n th??nh c??ng s??? ti???n l?? : ${_money.text.toString()} GBP",
                                    title: 'Th??ng b??o');
                                _money.clear();
                              } else if (mustpay == 0) {
                                final prefs = await SharedPreferences
                                    .getInstance();
                                String? token =
                                await prefs.getString("token");
                                await getbillinformation.getbill(
                                    constant.idshop,
                                    token!,
                                    1,
                                    "desc");
                                _showTopFlash(
                                    messager:
                                    "H??a ????n ${constant.TitleApp_Bill} ???? thanh to??n th??nh c??ng s??? ti???n l?? : ${_money.text.toString()} GBP",
                                    title: 'Th??ng b??o');
                                // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Billlist()));
                              } else {
                                checkactive = false;
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: AddCredit_check.ContentError,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 100,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                            Navigator.pop(context);
                          },
                      ),

                      CupertinoDialogAction(
                          child: Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => Navigator.pop(context))
                    ]),
              ),
            ));
  }
}
