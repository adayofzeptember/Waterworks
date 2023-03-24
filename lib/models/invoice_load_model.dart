class Invoice_Load_Data {
  int id;
  String customerName;
  String customerAddress;
  String invoiceNumber;
  String areaNumber;
  String write_date;
  String sumService;
  String vat;
  String total;
  int debt_months;
  String sum_debt;
  String godTotal;
  String bank;
  String prapa_cost;
  String waterMeterRecord_waterNumber;
  bool waterMeterRecord_waterWrong;
  String waterMeterRecord_record_date_format;
  String waterMeterRecord_previous_unit;
  String waterMeterRecord_current_unit;
  String waterMeterRecord_sum_unit;

  Invoice_Load_Data(
      {required this.id,
      required this.customerName,
      required this.customerAddress,
      required this.invoiceNumber,
      required this.areaNumber,
      required this.write_date,
      required this.prapa_cost,
      required this.sumService,
      required this.vat,
      required this.bank,
      required this.debt_months,
      required this.sum_debt,
      required this.godTotal,
      required this.total,
      required this.waterMeterRecord_current_unit,
      required this.waterMeterRecord_sum_unit,
      required this.waterMeterRecord_previous_unit,
      required this.waterMeterRecord_waterNumber,
      required this.waterMeterRecord_record_date_format,
      required this.waterMeterRecord_waterWrong});
}
