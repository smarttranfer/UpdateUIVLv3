import 'package:flutter/cupertino.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/funtion_app/history/history_creat_credit/history_credit.dart';

import '../model/sc_history/history_credit/history_credit.dart';

class managen_credit_history extends ChangeNotifier{



  List<history_credit> CreditResult(){
    return constant_history.listhistory_credit;
  }

  void increase(history_credit history){
    constant_history.listhistory_credit.add(history);
    notifyListeners();
  }

}