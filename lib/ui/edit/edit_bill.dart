import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apigetbill/fn_getbill.dart';
import 'package:vldebitor/funtion_app/edit_bill/edit_bill.dart';
import 'package:vldebitor/funtion_app/edit_bill/status_edit.dart';
import 'package:vldebitor/theme/Color_app.dart';
import 'package:vldebitor/ui/createbill/fn_createbill/createbill_status.dart';
import 'package:vldebitor/ui/createbill/fn_createbill/getshop.dart';
import '../../utilities/constants.dart';
import '../addbill/addbill.dart';
import '../home/home.dart';



class EditBillScreen extends StatefulWidget {
  int ID_bill;
  double original_amount;
  String name;
  String create_date;
  EditBillScreen(this.ID_bill ,this.name , this.original_amount,this.create_date);
  @override
  _EditBillScreen createState() => _EditBillScreen();
}

class _EditBillScreen extends State<EditBillScreen> {

  bool _isLoaderVisible = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController Money = TextEditingController();
  final TextEditingController Shop = TextEditingController();
  final TextEditingController Note = TextEditingController();
  initState(){
    name..text = widget.name;
    Money..text = widget.original_amount.toString();
  }
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
  // Widget _buildSelectCustomer() {
  //   return Column(
  //     children: [
  //       SizedBox(height: 10.0),
  //       Container(
  //           alignment: Alignment.centerLeft,
  //           decoration: kBoxDecorationStyle,
  //           height: 60.0,
  //           child: TextField(
  //             readOnly: true,
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontFamily: 'OpenSans',
  //             ),
  //             controller: Shop,
  //             decoration: InputDecoration(
  //               border: InputBorder.none,
  //               contentPadding: EdgeInsets.only(top: 14.0),
  //               prefixIcon: Icon(
  //                 Icons.shop,
  //                 color: Colors.white,
  //               ),
  //               hintText: "Chọn tên cửa hàng",
  //               hintStyle: kHintTextStyle,
  //             ),
  //           ))
  //     ],
  //   );
  // }
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
            inputFormatters: <TextInputFormatter>[
              CurrencyTextInputFormatter(
                locale: 'EN',
                decimalDigits: 2,
                symbol: '',
              ),
              // formatter,
            ],
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
  Future _CreaterCustomers() async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString("token").toString();
    if(Money.text.isNotEmpty|name.text.isNotEmpty|Note.text.isNotEmpty){
      fn_edit_bill.fn_edit_bills(widget.ID_bill, name.text, double.parse(Money.text), Note.text, widget.create_date, token);
    }else{
      Fluttertoast.showToast(
          msg: "Bạn chưa nhập đủ thông tin",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
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
          await _CreaterCustomers();
          setState(() {
            _isLoaderVisible = false;
          });
          if (edit_bill.edit_bills==true) {
            Fluttertoast.showToast(
                msg: "Sửa đơn thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            final prefs = await SharedPreferences.getInstance();
            String? token = await prefs.getString("token");
            await getbillinformation.getbill(constant.idshop, token!,1,"desc");
            await getshopinformation_createbills.getshopinformation_id(constant.indexcustomer, token);
            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Billlist()));
          } else {
            Fluttertoast.showToast(
                msg: "Sửa đơn thất bại",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
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
          'Sửa thông tin',
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
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            String? token = await prefs.getString("token");
            await getbillinformation.getbill(constant.idshop, token!,1,"desc");
            await getshopinformation_createbills.getshopinformation_id(constant.indexcustomer, token);
            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Billlist()));
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
              "Sửa thông tin đơn",
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
                      _buildEmailTF(),
                      SizedBox(
                        height: 6.0,
                      ),
                      _buildPasswordTF(),
                      SizedBox(
                        height: 6.0,
                      ),
                      _buildNoteTF(),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height/1.9,
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
