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
 

  Invoice_Load_Data(
      {this.id,
      this.fiveMonths_Back_Model,
      this.water_meter_record_nowUnit,
      this.water_meter_record_nowMonth,
      this.water_meter_record_beforeMonth,
      this.water_meter_record_beforeUnit,
      this.sum_months,
      this.sum_invoice,
      this.debt_months_step,
      this.dueDate,
      this.sum_total,
      this.total_format,
      this.sum_total_text,
      this.customerName,
      this. month,
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



