class ToInvoice {
  String? inv_number;
  String? inv_user_number;
  String? inv_user_name;
  String? inv_user_address;
  String? inv_user_area;

  String? inv_current_month;

  String? inv_matr_now_number;
  String? inv_matr_previous_number;
  String? inv_matr_now_month;
  String? inv_matr_previous_month;

  String? inv_unit_use;
  String? inv_prapa_cost;

  String? inv_service;
  String? inv_vat;
  String? wrong_water;

  String? inv_total;

  String? inv_sum_months;
  String? inv_sum_invoice;
  String? godTotal;
  List? inv_qr;
  String? inv_barcode2;
  String? dueDate;

  ToInvoice(
      {this.inv_number,
      this.inv_user_number,
      this.inv_user_name,
      this.inv_user_address,
      this.inv_unit_use,
      this.inv_prapa_cost,
      this.inv_service,
      this.dueDate,
      this.inv_barcode2,
      this.inv_vat,
      this.wrong_water,
      this.inv_total,
      this.inv_qr,
      this.godTotal});
}
