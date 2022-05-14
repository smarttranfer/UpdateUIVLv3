class md_detail_bill {
  late String Name_bill;
  late String ID;
  late String Date;
  late String Total;
  late String Paid;

  md_detail_bill(this.Name_bill, this.ID, this.Date, this.Total, this.Paid);

  String get Name_bill_detail {
    return Name_bill;
  }

  void set Name_bill_detail(String Name_bill) {
    Name_bill = Name_bill;
  }

  String get ID_detail {
    return ID;
  }

  void set ID_detail(String ID) {
    ID = ID;
  }

  String get Date_detail {
    return Date;
  }

  void set Date_detail(String Date) {
    Date = Date;
  }

  String get Total_detail {
    return Total;
  }

  void set Total_detail(String Total) {
    Total = Total;
  }

  String get Paid_detail {
    return Paid;
  }

  void set Paid_detail(String Paid) {
    Paid = Paid;
  }
}
