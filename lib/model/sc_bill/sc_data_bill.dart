class sc_data_bill {
  late int ID;
  late String Name;
  late double payment;
  late String content;
  late double original_amount;
  late int user_id;
  late int shop_id;
  late String status;
  late String transaction_status;
  late String create_date;


  int get ID_detail {
    return ID;
  }

  void set ID_detail(int ID) {
    ID = ID;
  }

  String get Name_detail {
    return Name;
  }

  void set Name_detail(String Name) {
    Name = Name;
  }

  double get payment_detail {
    return payment;
  }

  void set payment_detail(double payment) {
    payment = payment;
  }

  String get content_detail {
    return content;
  }

  void set content_detail(String content) {
    content = content;
  }

  double get original_amount_detail {
    return original_amount;
  }

  void set original_amount_detail(double original_amount) {
    original_amount = original_amount;
  }

  int get user_id_detail {
    return user_id;
  }

  void set user_id_detail(int user_id) {
    user_id = user_id;
  }

  int get shop_id_detail {
    return shop_id;
  }

  void set shop_id_detail(int shop_id) {
    shop_id = shop_id;
  }

  String get status_detail {
    return status;
  }

  void set status_detail(String status) {
    status = status;
  }

  String get transaction_status_detail {
    return transaction_status;
  }

  void set transaction_status_detail(String transaction_status) {
    transaction_status = transaction_status;
  }

  String get create_date_detail {
    return create_date;
  }

  void set create_date_detail(String create_date) {
    create_date = create_date;
  }
}