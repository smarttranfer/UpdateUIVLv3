import 'package:vldebitor/model/sc_datahome/sc_datahome_bill.dart';

class sc_datahome_customer {
  late String ID;
  late String Name_Custome;
  late String Phome;
  late List<sc_datahome_bill> ListBills = [];

  String get ID_detail {
    return ID;
  }

  void set ID_detail(String ID) {
    ID = ID;
  }

  String get Name_Custome_detail {
    return Name_Custome;
  }

  void set Phome_detail(String Phome) {
    Phome = Phome;
  }

  List<sc_datahome_bill> get ListBill_detail {
    return ListBills;
  }

  void set ListBill_detail(List<sc_datahome_bill> ListBills) {
    ListBills = ListBills;
  }
  
}