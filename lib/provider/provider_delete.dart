import 'package:flutter/cupertino.dart';

class managen_delete extends ChangeNotifier{
  bool status = false;
  bool DeleteResult(){
    return status;
  }

  void setStatudtrue(bool increase_true){
    status = increase_true;
    notifyListeners();
  }

  void setStatudfrue(bool decrease_false){
    status = decrease_false;
    notifyListeners();
  }
}