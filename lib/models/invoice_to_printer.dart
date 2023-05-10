class ToInvoice {
  String? inv_number;
  String? inv_user_number;
  String? inv_user_name;
  String? inv_user_address;
  String? inv_user_area;

  String? inv_current_montht;
  String? inv_matr_now_number_andMonth;
  String? inv_matr_previous_number_andMonth;

  String? inv_unit_use;
  String? inv_prapa_cost;

  String? inv_service;
  String? inv_vat;

  String? inv_total;

  String? inv_sum_months;
  String? inv_sum_invoice;
  String? godTotal;
  List? inv_barcode;
  String? inv_barcode2;

  ToInvoice(
      {this.inv_number,
      this.inv_user_number,
      this.inv_user_name,
      this.inv_user_address,
      this.inv_unit_use,
      this.inv_prapa_cost,
      this.inv_service,
      this.inv_barcode2,
      this.inv_vat,
      this.inv_total,
      this.inv_barcode,
      this.godTotal});
}
