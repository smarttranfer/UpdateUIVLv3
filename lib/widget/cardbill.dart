import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/ui/develop/develop.dart';
import '../funtion_app/transation_page/transation_page.dart';
import '../provider/manager_credit.dart';
import '../theme/Color_app.dart';
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Icon(
                                          Icons.remove_circle_outline_sharp,
                                          color: Colors.grey,
                                          size: 33.0,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: EditBillScreen(widget.id,double.parse(widget.Total)-double.parse(widget.Paid),widget.name,widget.street_name,widget.post_code)));
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Edit  ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w400,
                                                      decoration: TextDecoration.none,
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
                                      onPressed: () {
                                        _showWarningMessage(
                                            "Do you want delete customer ?");
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
                                          Text("Delete Shop",
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
                        Text(
                          "Tên hóa đơn: ${widget.name}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Mã hóa đơn: ${widget.ID}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "Số nợ: ${widget.Total}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "Đã trả: ${widget.Paid}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "Phải trả: ${widget.Rest}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "Ngày tạo: ${widget.date_create}",
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
                        onPressed: () {
                          // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: Develop()));
                          // transation_page.transation_router(Develop(), 2);
                        },
                        child: Text("Lịch sử"),
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
                              : _showWarningMessage("Số dư hiện tại của khách hàng đang là 0. Bạn cần yêu cầu khách hàng nạp tiền để thực hiện thanh toán");
                        },
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
