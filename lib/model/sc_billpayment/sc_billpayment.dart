import 'dart:ffi';

class history_paymentbill{
  late int id;
  late String user;
  late String invoice;
  late String payment;
  late String create_date;

  int get ids{
    return id ;
  }

  void set ids(int id){
    id = id;
  }

  String get users{
    return user ;
  }

  void set users(String user){
    user = user;
  }

  String get invoices{
    return invoice ;
  }

  void set invoices(String invoice){
    invoice = invoice;
  }

  String get payments{
    return payment ;
  }

  void set payments(String payment){
    payment = payment;
  }

  String get create_dates{
    return create_date ;
  }

  void set create_dates(String create_date){
    create_date = create_date;
  }

}