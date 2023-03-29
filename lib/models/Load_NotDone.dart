class NotWrite_Model {
  int? id;
  int? invoiceID;
  String? customerName;
  String? waterNumber; //
  String? areaNumber;
  String? customerAddress;
  String? meterNumber;
  bool? status;
  bool? statusSearchCheck;

  NotWrite_Model(
      {
        
     this.id,
     this.customerName,
     this.waterNumber,
      this.invoiceID,
      this.areaNumber,
     this.customerAddress,
     this.meterNumber,
     this.status,
      this.statusSearchCheck});
}
