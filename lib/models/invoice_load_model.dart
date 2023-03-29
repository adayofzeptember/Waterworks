class Invoice_Load_Data {
  int? id;
  String? customerName;
  String? customerAddress;
  String? invoiceNumber;
  String? areaNumber;
  String? write_date;
  String? sumService;
  String? vat;
  String? total;
  int? debt_months;
  String? sum_debt;
  String? godTotal;
  String? bank;
  String? prapa_cost;
  String? duedate;
  String? waterMeterRecord_waterNumber;
  bool? waterMeterRecord_waterWrong;
  String? waterMeterRecord_record_date_format;
  String? waterMeterRecord_previous_unit;
  String? waterMeterRecord_current_unit;
  String? waterMeterRecord_sum_unit;

  Invoice_Load_Data(
      {this.id,
      this.customerName,
      this.customerAddress,
      this.invoiceNumber,
       this.areaNumber,
       this.write_date,
       this.prapa_cost,
       this.sumService,
       this.vat,
       this.bank,
       this.debt_months,
       this.duedate,
       this.sum_debt,
       this.godTotal,
       this.total,
       this.waterMeterRecord_current_unit,
       this.waterMeterRecord_sum_unit,
       this.waterMeterRecord_previous_unit,
       this.waterMeterRecord_waterNumber,
       this.waterMeterRecord_record_date_format,
       this.waterMeterRecord_waterWrong});
}
