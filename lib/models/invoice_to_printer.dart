class ToInvoice {
  String? inv_number;
  String? inv_user_number;
  String? inv_user_name;
  String? inv_user_address;
  String? inv_user_area;

  String? inv_record_date;
  String? inv_matr_number;
  String? inv_matr_previous_number;

  String? inv_unit_use;
  String? inv_prapa_cost;

  String? inv_service;
  String? inv_vat;
  String? inv_total;
  String? inv_notPay;
  String? inv_notPay_money;
  String? inv_dueDate;
  String? inv_barcode;
  String? godTotal;

  ToInvoice(
      {this.inv_number,
      this.inv_user_number,
      this.inv_user_name,
      this.inv_user_address,
      this.inv_record_date,
      this.inv_matr_number,
      this.inv_matr_previous_number,
      this.inv_unit_use,
      this.inv_prapa_cost,
      this.inv_notPay_money,
      this.inv_service,
      this.inv_vat,
      this.inv_total,
      this.inv_barcode,
      this.inv_dueDate,
      this.godTotal});
}




