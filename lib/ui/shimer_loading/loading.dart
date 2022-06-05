import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../utilities/constants.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: App_Color.Background,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: App_Color.background_textfield,
              highlightColor: Colors.black26,
              enabled: true,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                          margin: EdgeInsets.only(
                              top: 0, bottom: 16, left: 8, right: 8),
                          color: App_Color.background_search,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          shadowColor: Colors.black54,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 0, bottom: 4, top: 0, right: 9),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "",
                                            style: kLabelStyle,
                                            textDirection: TextDirection.ltr,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "",
                                            style: kLabelStyle,
                                            textDirection: TextDirection.ltr,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "",
                                            style: kLabelStyle,
                                            textDirection: TextDirection.ltr,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "",
                                            style: kLabelStyle,
                                            textDirection: TextDirection.ltr,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "",
                                            style: kLabelStyle,
                                            textDirection: TextDirection.ltr,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "",
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
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          color:
                                          App_Color.orange, // background
                                          textColor:
                                          Colors.white, // foreground
                                          onPressed: () {
                                            // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: Develop()));
                                            // transation_page.transation_router(Develop(), 2);
                                          },
                                          child: Text("Lịch sử"),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        MaterialButton(
                                          disabledColor: App_Color.green
                                              .withOpacity(0.2),
                                          minWidth: 70,
                                          height: 30,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          color:
                                          App_Color.green, // background
                                          textColor:
                                          Colors.white, // foreground
                                          onPressed: () {},
                                          child: Text("Thanh toán"),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                itemCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

