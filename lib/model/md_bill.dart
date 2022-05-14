import 'package:vldebitor/model/md_detail_bill.dart';

class md_bill_shop{
  late String Name;
  late String Adrress;
  late String Bill;
  late String Money;
  late String Date_create;
  late List<md_detail_bill> listbill;
  String get Name_shop {
    return Name;
  }

  void set Name_shopp(String Name) {
    Name = Name;
  }

  String get Adrress_shop {
    return Adrress;
  }

  void set Adrress_shopp(String Adrress) {
    Adrress = Adrress;
  }

  String get Bill_shop {
    return Bill;
  }

  void set Bill_shopp(String Bill) {
    Bill = Bill;
  }


  String get Money_shop {
    return Money;
  }

  void set Money_shopp(String Money) {
    Money = Money;
  }


  String get Date_create_shop {
    return Date_create;
  }

  void set Date_create_shopp(String Date_create) {
    Date_create = Date_create;
  }

  List<md_detail_bill> get listbill_shop {
    return listbill;
  }

  void set listbillshopp(List<md_detail_bill> listbill) {
    listbill = listbill;
  }

  md_bill_shop(this.Name,this.Adrress,this.Bill,this.Money,this.Date_create,this.listbill);

}