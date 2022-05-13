import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../theme/Color_app.dart';
import '../utilities/constants.dart';

class customelistcard extends StatelessWidget {
  String name;
  String Phone;
  String NameShop;
  String Bill;
  String Total;
  String Create;
  customelistcard(
      this.name, this.Phone, this.NameShop, this.Bill, this.Total, this.Create);

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
                          height: MediaQuery.of(context).size.height / 5,
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
                                        color: Colors.grey,
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
                                          width: 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Edit",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                decoration: TextDecoration.none,
                                                fontSize: 17,
                                                fontFamily: 'OpenSans',
                                              ),
                                            ),
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
                                        )
                                      ],
                                    )
                                  ]),
                              Container(
                                padding: EdgeInsets.only(left: 90),
                                child: Divider(
                                  color: Colors.black,
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
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text("Delete customer",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15,
                                          fontFamily: 'OpenSans',
                                        )),
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
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Container(
                  //       height: 80,
                  //       width: 80,
                  //       child: Image.asset(
                  //         "assets/user.png",
                  //         fit: BoxFit.contain,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Name: ${name}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Phone: ${Phone}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Shop: ${NameShop}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Bill: ${Bill}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Total: ${Total}",
                          style: kLabelStyle,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Credit: ${Create}",
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
                        minWidth: 80,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: App_Color.orange, // background
                        textColor: Colors.white, // foreground
                        onPressed: () {},
                        child: Text("Shops"),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 10,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: App_Color.green, // background
                        textColor: Colors.white, // foreground
                        onPressed: () {},
                        child: Text("Add Bill"),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
