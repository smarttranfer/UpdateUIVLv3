import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vldebitor/constants/constant_app.dart';
import '../../theme/Color_app.dart';
import '../../utilities/constants.dart';

class CardCredit extends StatefulWidget {
  String Total;
  String Paid;
  double Credit;

  CardCredit(this.Total, this.Paid, this.Credit);

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
                          height: 5,
                        ),
                        Text(
                          "Paid: ${widget.Paid}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Credit: ${constant.credit}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
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
                            onPressed:  () {},
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
}
