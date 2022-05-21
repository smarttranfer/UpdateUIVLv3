import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/addtocredit/addtocreadit.dart';
import 'package:vldebitor/funtion_app/addtocredit/fn_addtocredit.dart';
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
  final TextEditingController _money = TextEditingController();
  late bool checkactive = false;
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
                          "Total: ${widget.Total}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text(
                          "Paid: ${widget.Paid}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text(
                          "Credit: ${widget.Credit}",
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
                              "Add to Credit:",
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
                                  hintText: 'Enter Money',
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
                                _showErrorMessage("Do you want to deposit the amount ${_money.text} into your account.");
                              }else{
                                _showErrorMessage("You have not entered the amount.");
                              }

                            },
                            child: Text(" Add "),
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
                        await fn_AddToCredit.AddtoCredits(double.parse(_money.text), widget.ID, token!);
                        if(AddCredit_check.AddCredit_Succes==true){
                          setState(() {
                            widget.Credit = widget.Credit + double.parse(_money.text);
                          });
                          Fluttertoast.showToast(
                              msg: "Add Credit succesfull.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
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
                              gravity: ToastGravity.CENTER,
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
