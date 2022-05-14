import 'package:flutter/material.dart';
import 'package:vldebitor/theme/Color_app.dart';


final String update_SC = "Update  data Sucessfull";
final String update_F = "Update  data Fail";


final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  
);

final kBoxDecorationStyle = BoxDecoration(
  color: App_Color.background_textfield,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kBoxDecorationMoneyStyle = BoxDecoration(
  color: Colors.grey,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);