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

  //*new
  String? total_format;
  String? meter_number;
  String? sum_total;
  String? meter_name;
  String? month;
    List? fiveMonths_Back_Model;
        List? debtmonths_step;
    String? sum_months;
    String? sum_total_text;

 
  ToInvoice(
      {this.inv_number,
      this.fiveMonths_Back_Model,
      this.inv_user_number,
      this.inv_user_name,
      this.inv_user_address,
      this.debtmonths_step,
      this.sum_months,
      this.sum_total_text,
      this.meter_name,
      this.month,
      this.sum_total,
      this.inv_unit_use,
      this.inv_prapa_cost,
      this.total_format,
      this.meter_number,
      this.inv_service,
      this.dueDate,
      this.inv_barcode2,
      this.inv_vat,
      this.wrong_water,
      this.inv_total,
      this.inv_qr,
      this.godTotal});
}
