import 'package:flutter/cupertino.dart';
import 'package:vldebitor/constants/constant_app.dart';

class managen_credit extends ChangeNotifier{

    void increase(double increase_number){
      constant.credit+=increase_number;
      notifyListeners();
    }

    void decrease(double decrease_number){
      constant.credit-=decrease_number;
      notifyListeners();
    }
}