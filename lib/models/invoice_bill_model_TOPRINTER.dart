class ToInvoice {
  String? inv_user_name;

  String? inv_user_address;
  String? inv_tax;

  String? inv_user_area;
  String? inv_user_number;
  String? inv_number;

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
  String? zpl;
  List? fiveMonths_Back_Model;
  List? debtmonths_step;
  String? sum_months;
  String? sum_total_text;
  String? information_waterWrong;
  String? information_discountText;
  String? information_textDuedate;
  String? information_textOverdue;
  String? information_textAlert;
  String? information_textdebitbank;

  ToInvoice(
      {this.inv_number,
      this.fiveMonths_Back_Model,
      this.inv_user_number,
      this.inv_user_name,
      this.information_textAlert,
      this.information_textdebitbank,
      this.information_textDuedate,
      this.information_textOverdue,
      this.inv_user_address,
      this.debtmonths_step,
      this.information_discountText,
      this.information_waterWrong,
      this.sum_months,
      this.sum_total_text,
      this.meter_name,
      this.month,
      this.inv_tax,
      this.sum_total,
      this.inv_unit_use,
      this.zpl,
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

class ToPrint_Bill {
  String? bill_id;
  String? bill_number;
  String? bill_customerName;
  String? bill_customerAddress;
  String? bill_taxNumber;
  String? bill_areaNumber;
  String? bill_waterNumber;
  String? bill_Month;
  String? bill_meterNumber;
  String? bill_size;
  String? bill_invoiceNumber;
  String? bill_previousNumber;
  String? bill_nowNumber;
  String? bill_sumUnit;
  String? bill_sumFormat;
  String? bill_sumService;
  String? bill_discount;
  String? bill_vat;
  String? bill_totalFormat;
  String? bill_totalFormat_text;
  String? bill_zpl;

  String? bill_paymentType;
  String? bill_recieveName;
  String? bill_recievePosition;
  String? bill_issue_dateFormat;

  List? fiveMonths_Back_Model;

  ToPrint_Bill({
    this.bill_paymentType,
    this.bill_recieveName,
    this.bill_recievePosition,
    this.bill_issue_dateFormat,
    this.bill_sumUnit,
    this.bill_totalFormat_text,
    this.bill_id,
    this.bill_previousNumber,
    this.bill_nowNumber,
    this.fiveMonths_Back_Model,
    this.bill_Month,
    this.bill_customerName,
    this.bill_customerAddress,
    this.bill_taxNumber,
    this.bill_zpl,
    this.bill_number,
    this.bill_invoiceNumber,
    this.bill_areaNumber,
    this.bill_meterNumber,
    this.bill_waterNumber,
    this.bill_size,
    this.bill_sumFormat,
    this.bill_sumService,
    this.bill_discount,
    this.bill_vat,
    this.bill_totalFormat,
  });
}
