import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vldebitor/funtion_app/history/history_creat_credit/gethistory_credit.dart';
import 'package:vldebitor/provider/manager_history_credit.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../../utilities/constants.dart';
import '../home/home.dart';
import 'cardcredit.dart';
import 'historycredit.dart';

class CreditScreen extends StatefulWidget {
  int ID;
  String Total;
  String Paid;
  double Credit;
  CreditScreen(
      {required this.ID,
      required this.Total,
      required this.Paid,
      required this.Credit,
      Key? key})
      : super(key: key);

  @override
  _CreditScreen createState() => _CreditScreen();
}

class _CreditScreen extends State<CreditScreen> {
  bool checknull = false;
  bool check_loding_data = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Home_page()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: App_Color.Background,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            "Nạp tiền",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          )),
          actions: [
            Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 50,
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(2),
          color: App_Color.Background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Container(
                  child: Column(
                children: [
                  CardCredit(
                      widget.ID, widget.Total, widget.Paid, widget.Credit),
                  Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Lịch sử",
                      style: kLabelStyleHistory,
                      textDirection: TextDirection.ltr,
                    )
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/2,
                    child: Provider.of<managen_credit_history>(context, listen: true).CreditResult().isNotEmpty
                        ? ListView.builder(
                            itemCount: Provider.of<managen_credit_history>(context, listen: true).CreditResult().length,
                            itemBuilder: (BuildContext context, int index) {
                              return History_credit(
                                  Provider.of<managen_credit_history>(context, listen: true).CreditResult()[index].create_date,
                                  Provider.of<managen_credit_history>(context, listen: true).CreditResult()[index].credit.toString(),
                                  Provider.of<managen_credit_history>(context, listen: true).CreditResult()[index].user_id.toString());
                            })
                        : Container(
                            child: Center(
                                child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText("Not Data",
                                  textStyle: TextStyle(color: App_Color.green)),
                            ],
                            isRepeatingAnimation: true,
                          ))),
                  )
                ],
              ))
            ],
          ),
        )));
  }
}
