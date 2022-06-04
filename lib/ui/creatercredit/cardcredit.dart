import 'dart:ui';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/addtocredit/addtocreadit.dart';
import 'package:vldebitor/funtion_app/addtocredit/fn_addtocredit.dart';
import '../../provider/manager_credit.dart';
import '../../theme/Color_app.dart';
import '../../utilities/constants.dart';

class CardCredit extends StatefulWidget {
  int ID ;
  String Total;
  String Paid;
  double Credit;

  CardCredit(this.ID,this.Total, this.Paid, this.Credit);

  @override
  State<StatefulWidget> createState() {
    return _CardCredit();
  }
}

class _CardCredit extends State<CardCredit> {
  double creditcopy = 0.0;
  @override
  void initState() {
    creditcopy = widget.Credit;
    super.initState();
  }
  final TextEditingController _money = TextEditingController();
  late bool checkactive = false;
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
                          "Tổng nợ: ${money_formart(widget.Total)}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text(
                          "Đã trả: ${money_formart(widget.Paid)}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text(
                          "Phải trả: ${money_formart((double.parse(widget.Total)-double.parse(widget.Paid)).toString())}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text(
                          "Số dư: ${money_formart(widget.Credit.toString())}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Số tiền:",
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
                                  // formatter,
                                ],
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
                            onPressed:  () {
                              if(_money.text.isNotEmpty){
                                _showErrorMessage("Bạn có chắc chắn muốn nạp ${_money.text} vào tài khoản này không ? ");

                              }else{
                                _showErrorMessage("You have not entered the amount.");
                              }

                            },
                            child: Text(" Nạp tiền "),
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
                content: Text("${messenger}"),
                actions: [
                  CupertinoDialogAction(
                      child: Text(
                        "Đồng ý",
                        style: TextStyle(color: Colors.green),
                      ),
                      onPressed: () async{
                        final prefs = await SharedPreferences.getInstance();
                        String? token =await prefs.getString("token").toString();
                        await fn_AddToCredit.AddtoCredits(double.parse(_money.text.toString().replaceAll(",", "")), widget.ID, token);
                        if(AddCredit_check.AddCredit_Succes==true){
                          Provider.of<managen_credit>(context, listen: false).increase(double.parse(_money.text.toString().replaceAll(",", "")));
                          Fluttertoast.showToast(
                              msg: "Add Credit succesfull.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          Navigator.pop(context);
                          Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
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
                        "Hủy",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.pop(context))
                ]),
          ),
        ));
  }
}
