import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/funtion_app/apiregistershop/registershop.dart';
import 'package:vldebitor/theme/Color_app.dart';
import '../../funtion_app/apiregistershop/fn_registershop.dart';
import '../../utilities/constants.dart';
import '../home/home.dart';

class ShopregisterScreen extends StatefulWidget {
  @override
  _ShopregisterScreen createState() => _ShopregisterScreen();
}

class _ShopregisterScreen extends State<ShopregisterScreen> {
  bool _rememberMe = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController House = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController postcode = TextEditingController();
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
              hintText: 'Nhập tên shop',
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
            controller: House,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.numbers_sharp,
                color: Colors.white,
              ),
              hintText: 'Số nhà',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdressTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: address,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              hintText: 'Địa chỉ',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostCodeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: postcode,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.code,
                color: Colors.white,
              ),
              hintText: 'Mã bưu chính',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Future _CreaterShop(
      String name, String phone, String address, String postcode) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    int? Ct_id = prefs.getInt("id_custome");
    await CreaterShop.CreaterShops(
        token, name, phone, address, postcode, Ct_id!);
  }

  Widget _buildAddShopBtn() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (name.text.isEmpty |
          House.text.isEmpty |
              address.text.isEmpty |
              postcode.text.isEmpty) {
            _showErrorMessage(
                "Bạn cần nhập đủ thông tin của cửa hàng");
          } else {
            await _CreaterShop(
                name.text, House.text.replaceAll(" ", ""), address.text.replaceAll(" ", ""), postcode.text.replaceAll(" ", ""));
            if (registershop.Create_Shop_Succes == true) {
              name.text = "";  House.text = ""; address.text = ""; postcode.text = "";
              Fluttertoast.showToast(
                  msg: "Tạo cửa hàng thành công.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: App_Color.green.withOpacity(0.9),
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              _showErrorMessage(registershop.ContentError);
            }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: App_Color.orange,
        child: Text(
          'Thêm cửa hàng mới',
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

  Widget _buildCRCustomerBtn() {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 1.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (name.text.isEmpty |
          House.text.isEmpty |
              address.text.isEmpty |
              postcode.text.isEmpty) {
            _showErrorMessage(
                "Bạn cần nhập đủ thông tin của cửa hàng");
          } else {
            await _CreaterShop(
                name.text, House.text.replaceAll(" ", ""), address.text.replaceAll(" ", ""), postcode.text.replaceAll(" ",""));
            if (registershop.Create_Shop_Succes == true) {
              Fluttertoast.showToast(
                  msg: "Create Shop Done",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 100,
                  backgroundColor: App_Color.green.withOpacity(0.9),
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.pushNamed(context, '/registerCustome');
            } else {
              _showErrorMessage(registershop.ContentError);
            }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.lightBlue,
        child: Text(
          'Tạo khách hàng',
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

  Widget _buildDoneBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (name.text.isEmpty |
          House.text.isEmpty |
              address.text.isEmpty |
              postcode.text.isEmpty) {
            _showErrorMessage(
                "Bạn cần nhập đủ thông tin của cửa hàng");
          } else {
            await _CreaterShop(
                name.text, House.text, address.text, postcode.text.replaceAll(" ", ""));
            if (registershop.Create_Shop_Succes == true) {
              Fluttertoast.showToast(
                  msg: "Tạo cửa hàng thành công",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: App_Color.green.withOpacity(0.9),
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            } else {
              _showErrorMessage(registershop.ContentError);
            }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: App_Color.green,
        child: Text(
          'Hoàn thành',
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
        automaticallyImplyLeading: false,
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
          "Tạo cửa hàng",
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
        child: GestureDetector(
          // onHorizontalDragUpdate: (details) async {
          //   if (details.delta.dx > 0) {
          //     if (name.text.isEmpty |
          //     House.text.isEmpty |
          //         address.text.isEmpty |
          //         postcode.text.isEmpty) {
          //       _showErrorMessage(
          //           "Bạn cần nhập đủ thông tin của cửa hàng");
          //     } else {
          //       await _CreaterShop(
          //           name.text, House.text, address.text, postcode.text);
          //       if (registershop.Create_Shop_Succes == true) {
          //         Fluttertoast.showToast(
          //             msg: "Tạo shop thành công",
          //             toastLength: Toast.LENGTH_SHORT,
          //             gravity: ToastGravity.BOTTOM,
          //             timeInSecForIosWeb: 1
          //             backgroundColor: App_Color.green.withOpacity(0.9),
          //             textColor: Colors.white,
          //             fontSize: 16.0);
          //         Navigator.of(context).pushNamedAndRemoveUntil(
          //             '/home', (Route<dynamic> route) => false);
          //       } else {
          //         _showErrorMessage(registershop.ContentError);
          //       }
          //       Navigator.of(context).pushNamedAndRemoveUntil(
          //           '/home', (Route<dynamic> route) => false);
          //     }
          //     // Right Swipe
          //   }
          // },
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
                      _buildAdressTF(),
                      SizedBox(
                        height: 6.0,
                      ),
                      _buildPostCodeTF(),
                      SizedBox(
                        height: 250.0,
                      ),
                      _buildCRCustomerBtn(),
                      _buildDoneBtn(),
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

  _showErrorMessage(String content) {
    showCupertinoDialog(
        context: context,
        builder: (context) => Theme(
              data: ThemeData.dark(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: CupertinoAlertDialog(
                    title: Text("Cảnh báo"),
                    content: Text("${content}"),
                    actions: [
                      CupertinoDialogAction(
                          child: Text(
                            "Đóng",
                            style: TextStyle(color: App_Color.green),
                          ),
                          onPressed: () => Navigator.pop(context))
                    ]),
              ),
            ));
  }
}
