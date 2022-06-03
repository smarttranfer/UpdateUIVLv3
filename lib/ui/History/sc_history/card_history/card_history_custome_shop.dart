import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vldebitor/constants/constant_app.dart';
import '../../../../theme/Color_app.dart';
import '../../../../utilities/constants.dart';



class History_customer_shop extends StatefulWidget {
  int idHistory;
  String Status;
  String Contents;
  String User;
  String Customer_Shop_id;
  String Create_date;

  History_customer_shop(this.idHistory, this.Status,this.Contents, this.User,this.Customer_Shop_id,this.Create_date);

  @override
  State<StatefulWidget> createState() {
    return _History_customer_shop();
  }
}

class _History_customer_shop extends State<History_customer_shop> {
  final TextEditingController _money = TextEditingController();
  late  bool checkactive = false;
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
                          "Trạng thái: ${widget.Status}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Nội dung thay đổi: ${widget.Contents}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Nhân viên: ${widget.User}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          constant.check_history_mode?"Khách hàng":"Shop: ${widget.Customer_Shop_id}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Ngày tạo: ${widget.Create_date}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
