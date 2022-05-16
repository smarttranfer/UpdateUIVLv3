import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../theme/Color_app.dart';
import '../utilities/constants.dart';

class cardbill extends StatefulWidget {
  String name;
  String address;
  String bill;
  String money;
  String date_create;

  cardbill(
      this.name, this.address, this.bill, this.money, this.date_create);

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

                                              },
                                              child: Column(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                children: [
                                                  Text("Edit  ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w400,
                                                      decoration:
                                                      TextDecoration.none,
                                                      fontSize: 17,
                                                      fontFamily: 'OpenSans',
                                                    ),),
                                                  Text("Edit information of shop",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                        TextDecoration.none,
                                                        fontWeight: FontWeight.w300,
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
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        _showWarningMessage("Do you want delete customer ?");
                                      },
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Text("Delete",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                              TextDecoration.none,
                                              fontSize: 17,
                                              fontFamily: 'OpenSans',
                                            ),),
                                          Text("Delete Shop",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                TextDecoration.none,
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
                          "Name: ${widget.name}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Address: ${widget.address}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Bill: ${widget.bill}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Money: ${widget.money}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Date created: ${widget.date_create}",
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
                        minWidth: 10,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: App_Color.orange, // background
                        textColor: Colors.white, // foreground
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/shopdetail', (Route<dynamic> route) => false);
                        },
                        child: Text("History"),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 70,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: App_Color.green, // background
                        textColor: Colors.white, // foreground
                        onPressed: () {},
                        child: Text("Pay"),
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
                title: Text("Warning" ,style: TextStyle(color: Colors.red),),
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