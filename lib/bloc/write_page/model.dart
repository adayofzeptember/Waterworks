class Invoice_Load_Data {
  int? id;
  String? customerName;
  String? customerAddress;
  String? invoiceNumber;
  String? areaNumber;
  String? water_meter_record_nowUnit;
  String? water_meter_record_nowMonth;
  String? water_meter_record_beforeUnit;
  String? water_meter_record_beforeMonth;
  String? sum_months;
  String? sum_invoice;
  String? sum_unit_use;
  String? invoiceStatus;
  String? write_date;
  String? sumService;
  String? vat;
  String? total;
  int? debt_months;
  String? sum_debt;
  String? tax;
  String? bank;
  String? bank_barcode;
  String? prapa_cost;
  String? issue_month;
  String? waterMeterRecord_waterNumber;
  String? meter_status;
  String? meter_status_text;
  String? dueDate;
  String? waterMeterRecord_record_date_format;
  String? waterMeterRecord_previous_unit;
  String? waterMeterRecord_current_unit;
  String? waterMeterRecord_sum_unit;
  //new
  String? total_format;
  String? meter_number;
  String? sum_total;
  String? meter_name;
  String? month;
  List? fiveMonths_Back_Model;
  List? debt_months_step;
  String? sum_total_text;
  String? zpl;
  String? information_waterWrong;
  String? information_discountText;
  String? information_textDuedate;
  String? information_textOverdue;
String? paymentAutoCheck;
  String? information_textAlert;
  String? information_textdebitbank;




  Invoice_Load_Data(
      {this.id,
      this.information_textAlert,
      this.information_textdebitbank,
      this.information_textDuedate,
      this.paymentAutoCheck,
      this.information_textOverdue,
 
      this.fiveMonths_Back_Model,
      this.water_meter_record_nowUnit,
      this.water_meter_record_nowMonth,
      this.information_waterWrong,
      this.information_discountText,
      this.tax,
      this.water_meter_record_beforeMonth,
      this.water_meter_record_beforeUnit,
      this.sum_months,
      this.sum_invoice,
      this.debt_months_step,
      this.dueDate,
      this.zpl,
      this.sum_total,
      this.total_format,
      this.sum_total_text,
      this.customerName,
      this.month,
      this.customerAddress,
      this.bank_barcode,
      this.invoiceStatus,
      this.invoiceNumber,
      this.areaNumber,
      this.meter_number,
      this.write_date,
      this.meter_name,
      this.meter_status_text,
      this.prapa_cost,
      this.sumService,
      this.vat,
      this.bank,
      this.sum_unit_use,
      this.debt_months,
      this.issue_month,
      this.sum_debt,
      this.total,
      this.waterMeterRecord_current_unit,
      this.waterMeterRecord_sum_unit,
      this.waterMeterRecord_previous_unit,
      this.waterMeterRecord_waterNumber,
      this.waterMeterRecord_record_date_format,
      this.meter_status});
}

class Bill_Load_Data {
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

  Bill_Load_Data({
    this.bill_paymentType,
    this.bill_recieveName,
    this.bill_recievePosition,
    this.bill_issue_dateFormat,
    this.bill_sumUnit,
    this.bill_zpl,
    this.bill_totalFormat_text,
    this.bill_id,
    this.bill_previousNumber,
    this.bill_nowNumber,
    this.fiveMonths_Back_Model,
    this.bill_Month,
    this.bill_customerName,
    this.bill_customerAddress,
    this.bill_taxNumber,
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

class FiveMonths_Back {
  String? month;
  String? sum_unit;

  FiveMonths_Back({this.month, this.sum_unit});
}

class DebtMonths_Step {
  String? name;
  String? total;

  DebtMonths_Step({this.name, this.total});
}
