import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/apiregistercustomer/registercustomer.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../funtion_app/apiregistercustomer/fn_registercustomer.dart';
import '../../utilities/constants.dart';
import '../../widget/process_loading.dart';
import '../home/home.dart';

class CustomeregisterScreen extends StatefulWidget {
  @override
  _CustomeregisterScreen createState() => _CustomeregisterScreen();
}

class _CustomeregisterScreen extends State<CustomeregisterScreen> {
  bool _rememberMe = false;
  bool _isLoaderVisible = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(
              'Fullname',
              style: kLabelStyle,
            ),
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
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
              hintText: 'Enter your fullname',
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
        Row(
          children: [
            Text(
              'Phone',
              style: kLabelStyle,
            ),
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
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
              hintText: 'Enter your Phone',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Future _CreaterCustomers(String Name, String Phone) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    await CreaterCustomer.CreaterCustomers(token,Name,Phone);

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
          await _CreaterCustomers(name.text,phone.text);
          setState(() {
            _isLoaderVisible = false;
          });
          if (registercustomer.Create_Customer_Succes == true && phone.value.text.toString().length == 11) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/registerShop', (Route<dynamic> route) => false);
          } else {
            if(phone.value.text.toString().length > 11||phone.value.text.toString().length < 11){
              _showErrorMessage("Your phone number is not 11 characters long");
            }else{
              _showErrorMessage("Your registration has a problem");
            }

          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: App_Color.green,
        child: Text(
          'Continue',
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false);
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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/registerCustome', (Route<dynamic> route) => false);
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
          "Create Custome",
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
                    // Right Swipe
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
                                  top: MediaQuery.of(context).size.height / 2,
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
