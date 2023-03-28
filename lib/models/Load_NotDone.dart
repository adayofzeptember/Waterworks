class NotWrite_Model {
  int id;
  int? invoiceID;
  String customerName;
  String waterNumber; //
  String areaNumber;
  String customerAddress;
  String meterNumber;
  bool status;
  bool? statusSearchCheck;

  NotWrite_Model(
      {required this.id,
      required this.customerName,
      required this.waterNumber,
      this.invoiceID,
      required this.areaNumber,
      required this.customerAddress,
      required this.meterNumber,
      required this.status,
      this.statusSearchCheck});
}
