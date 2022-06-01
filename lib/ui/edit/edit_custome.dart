import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apiedit_customer/apiedit_customer.dart';
import 'package:vldebitor/funtion_app/apiedit_customer/fn_edit_customer.dart';
import 'package:vldebitor/funtion_app/apiregistercustomer/registercustomer.dart';
import 'package:vldebitor/funtion_app/transation_page/transation_page.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../funtion_app/apiregistercustomer/fn_registercustomer.dart';
import '../../utilities/constants.dart';
import '../../widget/process_loading.dart';
import '../home/home.dart';
import '../shop/detail/detail.dart';
import '../shopregister/shopregister.dart';

class CustomereditScreen extends StatefulWidget {
  late int IDCustomer;
  late String NameCustomer;
  late String Telephone;
  CustomereditScreen(this.IDCustomer,this.NameCustomer,this.Telephone);
  @override
  _CustomereditScreen createState() => _CustomereditScreen();
}

class _CustomereditScreen extends State<CustomereditScreen> {
  bool _isLoaderVisible = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  @override
  void initState() {
    name..text =  widget.NameCustomer;
    phone..text = widget.Telephone;

    super.initState();
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
              hintText: 'Nhập tên',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
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
            controller: phone,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone_iphone_outlined,
                color: Colors.white,
              ),
              hintText: 'Nhập số điện thoại',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Future _edit_Customer(String Name, String Phone) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    await fn_edit_customer.fn_edit_customers(widget.IDCustomer,name.text,phone.text,token);

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
          await _edit_Customer(name.text,phone.text);
          setState(() {
            _isLoaderVisible = false;
          });
          if (edit_customer.edit_customers==true && phone.value.text.toString().length == 11) {
            Fluttertoast.showToast(
                msg: "Sửa thông tin thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: App_Color.green.withOpacity(0.9),
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            if(phone.value.text.toString().length > 11||phone.value.text.toString().length < 11){
              _showErrorMessage("Số điện thoại phải 11 số");
            }else{
              _showErrorMessage(edit_customer.edit_customer_error);
            }

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
          onPressed: () {
            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: Home_page()));
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

                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: Home_page()));
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
              "Sửa khách hàng",
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
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Home_page()));

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
                      _buildEmailTF(),
                      SizedBox(
                        height: 6.0,
                      ),
                      _buildPasswordTF(),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 1.7,
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
                title: Text("Warning",style: TextStyle(color: Colors.red),),
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
