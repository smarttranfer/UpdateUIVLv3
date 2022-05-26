import 'package:flutter/cupertino.dart';
import 'package:vldebitor/constants/constant_app.dart';

class managen_credit extends ChangeNotifier{

    double credit = 0.0;
    double creditcopy = 0.0;

    String CreditResult(){
      return credit.toStringAsFixed(2);
    }

    void increase(double increase_number){
      credit = creditcopy + increase_number;
      notifyListeners();
    }

    void decrease(double decrease_number){
      credit = credit - decrease_number;
      notifyListeners();
    }
}