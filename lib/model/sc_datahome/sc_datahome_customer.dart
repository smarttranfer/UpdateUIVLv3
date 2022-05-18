import 'dart:ffi';

import 'package:vldebitor/model/sc_datahome/sc_datahome_bill.dart';

class sc_datahome_customer {
  late String ID;
  late String Name_Custome;
  late String Phone;
  late double Unallocated;
  late int Total_shop;
  late int Total_invoice;
  late int Total_invoice_paid;
  late double Total_payment;
  late double Total_liabilities;

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

  double get Unallocated_detail {
    return Unallocated;
  }

  void set Unallocated_detail(double Unallocated) {
    Unallocated = Unallocated;
  }


  int get Total_shop_detail {
    return Total_shop;
  }

  void set Total_shop_detail(int Total_shop) {
    Total_shop = Total_shop;
  }


  int get Total_invoice_detail {
    return Total_invoice;
  }

  void set Total_invoice_detail(int Total_invoice) {
    Total_invoice = Total_invoice;
  }


  double get Total_payment_detail {
    return Total_payment;
  }

  void set Total_payment_detail(double Total_payment) {
    Total_payment = Total_payment;
  }


  double get Total_liabilities_detail {
    return Total_liabilities;
  }

  void set Total_liabilities_detail(double Total_liabilities) {
    Total_liabilities = Total_liabilities;
  }

  
}