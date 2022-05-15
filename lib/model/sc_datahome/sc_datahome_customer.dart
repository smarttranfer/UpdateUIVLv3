class sc_datahome_customer {
  late String ID;
  late String Name_Custome;
  late String Phome;
  late List<String> ListBill;

  sc_datahome_customer(this.ID, this.Name_Custome,  this.Phome, this.ListBill);

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

  List<String> get ListBill_detail {
    return ListBill;
  }

  void set ListBill_detail(List<String> ListBill) {
    ListBill = ListBill;
  }
  
}