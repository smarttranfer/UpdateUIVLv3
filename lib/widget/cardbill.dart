import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/history/history_bill_many/history_bil.dart';
import 'package:vldebitor/funtion_app/history/history_bill_many/history_bill_many.dart';
import 'package:vldebitor/funtion_app/history/history_edit_bill/history_edit_bill.dart';
import 'package:vldebitor/funtion_app/history/history_edit_bill/history_status_edit_bill.dart';
import 'package:vldebitor/ui/History/sc_history_bill_many/sc_history_bill_many.dart';
import 'package:vldebitor/ui/develop/develop.dart';
import '../funtion_app/transation_page/transation_page.dart';
import '../provider/manager_credit.dart';
import '../theme/Color_app.dart';
import '../ui/History/sc_history_edit_bill/sc_edit_bill.dart';
import '../ui/addbill/cardpayment.dart';
import '../ui/addbill/payone.dart';
import '../ui/edit/edit_bill.dart';
import '../ui/home/home.dart';
import '../ui/shop/detail/detail.dart';
import '../utilities/constants.dart';

class cardbill extends StatefulWidget {
  String name;
  String ID;
  String Total;
  String Paid;
  String Rest;
  String date_create;
  cardbill(
      this.name, this.ID, this.Total, this.Paid, this.Rest, this.date_create);

  @override
  State<StatefulWidget> createState() {
    return _cardbill();
  }
}

class _cardbill extends State<cardbill> {
  bool checkdelte = false;
  @override
  Widget build(BuildContext context) {
    MoneyFormatter Rest = MoneyFormatter(amount: double.parse(widget.Rest));
    MoneyFormatter Paid = MoneyFormatter(amount: double.parse(widget.Paid));
    MoneyFormatter Total = MoneyFormatter(amount: double.parse(widget.Total));
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
                                                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: EditBillScreen(int.parse(widget.ID),widget.name,double.parse(widget.Total),widget.date_create)));
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
                                        await gethistory_edit_bill.gethistory(token!, int.parse(widget.ID));
                                        if(constant_history_bill.history_edit_bill_sucess == true){
                                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: HistoryList_edit()));
                                        }
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
                                        // _showWarningMessage("B???n mu???n ???n th??ng tin n??y v???i user kh??ng ?", DeleteCustomer.DeleteCustomers(widget.ID_Custome, token!));

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
                          "T??n h??a ????n: ${widget.name}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "M?? h??a ????n: ${widget.ID}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "S??? n???: ${Total.output.nonSymbol}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "???? tr???: ${Paid.output.nonSymbol}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "Ph???i tr???: ${Rest.output.nonSymbol}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "Ng??y t???o: ${widget.date_create}",
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
                          await gethistory_bill_many.gethistory(int.parse(widget.ID), token!);
                          if(constant_history_billpayment.listhistory_billpayment_sucess == true){
                            Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,child: HistoryList_bill()));
                          }
                        },
                        child: Text("L???ch s???"),
                      )
                    ],
                  ),
                  SizedBox(width: 10,),
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
                        onPressed: double.parse(widget.Rest)==0.0?null:() {
                          double.parse(Provider.of<managen_credit>(context, listen: false).CreditResult()) > 0
                              ? Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: PayoneScreen(
                                        ID: int.parse(widget.ID),
                                        Total: widget.Total,
                                        Paid: widget.Paid,
                                        Credit: double.parse(widget.Rest,),
                                        Name: widget.name,
                                      )))
                              : _showWarningMessage("S??? d?? hi???n t???i c???a kh??ch h??ng ??ang l?? 0. B???n c???n y??u c???u kh??ch h??ng n???p ti???n ????? th???c hi???n thanh to??n");
                        },
                        child: Text("Thanh to??n"),
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
                    content: Text(message),
                    actions: [
                      CupertinoDialogAction(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () => Navigator.pop(context)),
                    ]),
              ),
            ));
  }
}
