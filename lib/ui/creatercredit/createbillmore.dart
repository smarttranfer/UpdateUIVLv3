import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/theme/Color_app.dart';
import 'package:vldebitor/ui/createbill/fn_createbill/createbill_status.dart';
import '../../model/sc_createbill/sc_createbill.dart';
import '../../utilities/constants.dart';
import '../createbill/fn_createbill/api_createbill.dart';
import '../home/home.dart';


class CreateBillScreenMore extends StatefulWidget {
  late List<sc_Create_bill> ListShop = [];
  late int index;
  late Widget BackScreen;
  CreateBillScreenMore(this.ListShop,this.index,this.BackScreen);
  @override
  _CreateBillScreenMore createState() => _CreateBillScreenMore();
}

class _CreateBillScreenMore extends State<CreateBillScreenMore> {
  bool _isLoaderVisible = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController Money = TextEditingController();
  final TextEditingController Shop = TextEditingController();
  final TextEditingController Note = TextEditingController();
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: name,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.drive_file_rename_outline_outlined,
                color: Colors.white,
              ),
              hintText: 'Nhập tên đơn',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildSelectCustomer() {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              readOnly: true,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              controller: Shop..text = widget.ListShop[widget.index].Name,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.shop,
                  color: Colors.white,
                ),
                hintText: widget.ListShop[0].Name,
                hintStyle: kHintTextStyle,
              ),
            ))
      ],
    );
  }
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: Money,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.money,
                color: Colors.white,
              ),
              hintText: '0.0',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildNoteTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: Note,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.note,
                color: Colors.white,
              ),
              hintText: 'Nhập ghi chú',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Future _CreaterCustomers(String Name, String Phone) async {
    int ID = 0;
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString("token").toString();
    for(var i in widget.ListShop){
      if(i.Name==Shop.text){
        ID = i.ID;
        break;
      }
    }
    String datetime = DateTime.now().toString();
    if(Money.text.isNotEmpty|name.text.isNotEmpty|Note.text.isNotEmpty|Shop.text.isNotEmpty){
      await Createbills.CreateBill(ID,token, double.parse(Money.text), name.text,Note.text,datetime);
    }else{
      Fluttertoast.showToast(
          msg: "Tạo đơn thất bại",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }


  }
  Widget _buildContinueBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          setState(() {
            _isLoaderVisible = true;
          });
          await _CreaterCustomers(name.text, Money.text);
          setState(() {
            _isLoaderVisible = false;
          });
          if (createbill.Create_Bill_Succes==true) {
            Fluttertoast.showToast(
                msg: "Tạo đơn thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pushReplacement(context,
                PageTransition(type: PageTransitionType.rightToLeft, child: widget.BackScreen));
          } else {
            Fluttertoast.showToast(
                msg: "Tạo đơn thất bại",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );

          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: App_Color.green,
        child: Text(
          'Tạo đơn',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {

            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: widget.BackScreen));
          },
        ),
        actions: [
          Container(
            // padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: widget.BackScreen));
                },
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: App_Color.background_search,
                    size: 24.0,
                  ),
                ),
              ))
        ],
        backgroundColor: App_Color.background_search,
        title: Center(
            child: Text(
              "Tạo đơn          ",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: _isLoaderVisible
            ? Container(
            color: App_Color.Background,
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: App_Color.background_search,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Card(
                            elevation: 4.0,
                            color: App_Color.background_search,
                            child: CircularProgressIndicator(
                              color: App_Color.green,
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Loading . . . .',
                            textStyle: TextStyle(color: App_Color.green)),
                      ],
                      isRepeatingAnimation: true,
                    )
                  ],
                )))
            : GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 0) {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Home_page()));
            }
          },
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                color: App_Color.Background,
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildSelectCustomer(),
                      SizedBox(
                        height: 6.0,
                      ),
                      _buildNoteTF(),
                      SizedBox(
                        height: 6.0,
                      ),
                      _buildEmailTF(),
                      SizedBox(
                        height: 6.0,
                      ),
                      _buildPasswordTF(),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2.6,
                            bottom: 10),
                        child: _buildContinueBtn(),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showErrorMessage(String messenger) {
    showCupertinoDialog(
        context: context,
        builder: (context) => Theme(
          data: ThemeData.dark(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: CupertinoAlertDialog(
                title: Text(
                  "Warning",
                  style: TextStyle(color: Colors.red),
                ),
                content: Text("${messenger}"),
                actions: [
                  CupertinoDialogAction(
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () => Navigator.pop(context))
                ]),
          ),
        ));
  }
}
