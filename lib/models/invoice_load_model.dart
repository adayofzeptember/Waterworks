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

  String? write_date;
  String? sumService;
  String? vat;
  String? total;
  int? debt_months;
  String? sum_debt;
  String? godTotal;
  String? bank;
  String? bank_barcode;
  String? prapa_cost;
  String? issue_month;
  String? waterMeterRecord_waterNumber;
  String? meter_status;
  String? meter_status_text;
  String? waterMeterRecord_record_date_format;
  String? waterMeterRecord_previous_unit;
  String? waterMeterRecord_current_unit;
  String? waterMeterRecord_sum_unit;

  Invoice_Load_Data(
      {this.id,
      this.water_meter_record_nowUnit,
      this.water_meter_record_nowMonth,
      this.water_meter_record_beforeMonth,
      this.water_meter_record_beforeUnit,
      this.sum_months,
      this.sum_invoice,
      this.customerName,
      this.customerAddress,
      this.bank_barcode,
      this.invoiceNumber,
      this.areaNumber,
      this.write_date,
      this.meter_status_text,
      this.prapa_cost,
      this.sumService,
      this.vat,
      this.bank,
      this.sum_unit_use,
      this.debt_months,
      this.issue_month,
      this.sum_debt,
      this.godTotal,
      this.total,
      this.waterMeterRecord_current_unit,
      this.waterMeterRecord_sum_unit,
      this.waterMeterRecord_previous_unit,
      this.waterMeterRecord_waterNumber,
      this.waterMeterRecord_record_date_format,
      this.meter_status});
}
