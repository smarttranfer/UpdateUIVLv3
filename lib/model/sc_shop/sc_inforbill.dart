import 'package:vldebitor/model/sc_datahome/sc_datahome_bill.dart';

class sc_Infor_Shop_Bill {
  late int ID;
  late int Shop_ID;
  late String Name;
  late String Content;
  late double Payment;
  late double Original_amount;
  late String Create_date;

  String get Content_detail {
    return Content;
  }

  void set Content_detail(String Content) {
    Content = Content;
  }


  int get ID_detail {
    return ID;
  }

  void set ID_detail(int ID) {
    ID = ID;
  }

  int get Shop_ID_detail {
    return Shop_ID;
  }

  void set Shop_ID_detail(int Shop_ID) {
    Shop_ID = Shop_ID;
  }

  String get Name_detail {
    return Name;
  }

  void set ListBill_detail(String Name) {
    Name = Name;
  }

  double get Payment_detail {
    return Payment;
  }

  void set Payment_detail(double Payment) {
    Payment = Payment;
  }

  double get Original_amount_detail {
    return Original_amount;
  }

  void set Original_amount_detail(double Original_amount) {
    Original_amount = Original_amount;
  }

  String get Create_date_detail {
    return Create_date;
  }

  void set Create_date_detail(String Create_date) {
    Create_date = Create_date;
  }
}
