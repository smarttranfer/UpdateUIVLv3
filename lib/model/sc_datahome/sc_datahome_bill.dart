class sc_datahome_bill {
  late String ID;
  late String Name;
  late String Phome;
  late String Payment;
  late String Street_name;
  late String Post_code;
  late String Customer_id;
  late String Original_amount;
  late String Create_date;

  sc_datahome_bill(this.ID, this.Name,  this.Phome, this.Payment ,this.Street_name ,this.Post_code,this.Customer_id,this.Original_amount,this.Create_date);

  String get ID_detail {
    return ID;
  }

  void set ID_detail(String ID) {
    ID = ID;
  }



}