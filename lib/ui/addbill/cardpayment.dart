import 'dart:ui';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
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
import '../../provider/manager_credit.dart';
import '../../theme/Color_app.dart';
import '../../utilities/constants.dart';
import 'addbill.dart';

class CardPayment extends StatefulWidget {
  int ID ;
  String Total;
  String Paid;
  double Credit;
  bool check ;
  CardPayment(this.ID,this.Total, this.Paid, this.Credit,this.check);

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
    String formart_money(String money){
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
                          "Số nợ: ${formart_money(total.toString())}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text(
                          "Đã trả: ${formart_money(paid.toString())}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text(
                          "Phải trả: ${formart_money(mustpay.toString())}",
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
                              "Thanh toán:",
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
                                onChanged: (e){
                                  try{
                                    if((double.parse(e.toString().replaceAll(",", ""))>double.parse(Provider.of<managen_credit>(context, listen: false).CreditResult())) ){
                                      setState(() {
                                        checkactive=false;
                                      });
                                      Fluttertoast.showToast(
                                          msg: "Số tiêng không đủ để thực hiện",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }else{
                                      if(double.parse(e.toString().replaceAll(",", "")) > mustpay){
                                        setState(() {
                                          checkactive=false;
                                        });
                                        Fluttertoast.showToast(
                                            msg: "Số tiền bạn nhập vượt quá số tiền phải trả",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }else{
                                        setState(() {
                                          checkactive = widget.check;
                                        });
                                      }


                                    }
                                  }catch(e){}

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
                            onPressed: checkactive? () async{
                              if(_money.text.isNotEmpty){
                                final prefs = await SharedPreferences.getInstance();
                                String? token =await prefs.getString("token").toString();
                                await fn_payment.Payment(double.parse(_money.text.replaceAll(",", "")), constant.indexcustomer, token,widget.ID);
                                if( payments.Create_payment_Succes==true){
                                  Provider.of<managen_credit>(context, listen: false).decrease(double.parse(_money.text.replaceAll(",", "")));
                                  if(mustpay > 0 && double.parse(Provider.of<managen_credit>(context, listen: false).CreditResult())>0){
                                    setState(() {
                                      paid = paid + double.parse(_money.text.replaceAll(",", ""));
                                      credit = credit - double.parse(_money.text.replaceAll(",", ""));
                                      mustpay = mustpay - double.parse(_money.text.replaceAll(",", ""));
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Thanh toán thành công.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    _money.clear();
                                  }else if(mustpay==0){
                                    final prefs = await SharedPreferences.getInstance();
                                    String? token = await prefs.getString("token");
                                    await getbillinformation.getbill(constant.idshop, token!,1,"asc");
                                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Billlist()));
                                  }
                                  else{
                                    checkactive=false;
                                  }


                                }else{
                                  Fluttertoast.showToast(
                                      msg: AddCredit_check.ContentError,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                              }else{
                                _showErrorMessage("Số tiền trong tài khoản không đủ");
                              }

                            }:null,
                            child: Text(" Thanh toán "),
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
  _showErrorMessage(String messenger) {
    showCupertinoDialog(
        context: context,
        builder: (context) => Theme(
          data: ThemeData.dark(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: CupertinoAlertDialog(
                title: Text("Warning",style: TextStyle(color: Colors.white),),
                content: Text("${messenger}"),
                actions: [
                  CupertinoDialogAction(
                      child: Text(
                        "yes",
                        style: TextStyle(color: Colors.green),
                      ),
                      onPressed: () async{
                        final prefs = await SharedPreferences.getInstance();
                        String? token =await prefs.getString("token").toString();
                        await fn_payment.Payment(double.parse(_money.text.replaceAll(",", "")), constant.indexcustomer, token,widget.ID);
                        if(AddCredit_check.AddCredit_Succes==true){
                          setState(() {
                            checkactive = false;
                            paid = paid + double.parse(_money.text.replaceAll(",", ""));
                            credit = credit - double.parse(_money.text.replaceAll(",", ""));
                            total = total - double.parse(_money.text.replaceAll(",", ""));
                          });
                          Fluttertoast.showToast(
                              msg: "Add Credit succesfull.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          Navigator.pop(context);
                        }else{
                          Fluttertoast.showToast(
                              msg: AddCredit_check.ContentError,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      }),
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
