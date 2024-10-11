part of 'write_page_bloc.dart';

// ignore_for_file: must_be_immutable
class WritePageState extends Equatable {
  int countForReset;
  String checkBilPrint;
  String writeRecordId;
  String customerName, address, waterNumber, areaNumber, meterNumber;
  String previousUnitFormat;
  dynamic invoices;
  dynamic invoice_data;
  dynamic bill_data;
  bool loading;
  bool buttonEnable;
  String whatPage, writeCondition;
  bool checkCurrentUnit;
  String lat;
  String lng;
  int statebillID;
  WritePageState({
    required this.lat,
    required this.checkBilPrint,
    required this.lng,
    required this.countForReset,
    required this.writeRecordId,
    required this.customerName,
    required this.address,
    required this.statebillID,
    required this.waterNumber,
    required this.areaNumber,
    required this.meterNumber,
    required this.buttonEnable,
    required this.bill_data,
    required this.previousUnitFormat,
    required this.invoices,
    required this.checkCurrentUnit,
    required this.invoice_data,
    required this.loading,
    required this.whatPage,
    required this.writeCondition,
  });

  WritePageState copyWith({
    int? countForReset,
    String? writeRecordId,
    String? customerName,
    String? address,
    String? waterNumber,
    String? checkBilPrint,
    String? areaNumber,
     int? statebillID,
    String? meterNumber,
    String? previousUnitFormat,
    String? statusMeter,
    dynamic invoices,
    bool? checkCurrentUnit,
    bool? buttonEnable,
    dynamic invoice_data,
      dynamic bill_data,
    bool? loading,
    String? whatPage,
    String? writeCondition,
    String? lat,
    String? lng,
  }) {
    return WritePageState(
      countForReset: countForReset ?? this.countForReset,
      writeRecordId: writeRecordId ?? this.writeRecordId,
      customerName: customerName ?? this.customerName,
      statebillID: statebillID ?? this.statebillID,
      checkBilPrint: checkBilPrint ?? this.checkBilPrint,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      bill_data: bill_data ?? this.bill_data,
      waterNumber: waterNumber ?? this.waterNumber,
      areaNumber: areaNumber ?? this.areaNumber,
      meterNumber: meterNumber ?? this.meterNumber,
      previousUnitFormat: previousUnitFormat ?? this.previousUnitFormat,
      invoices: invoices ?? this.invoices,
      checkCurrentUnit: checkCurrentUnit ?? this.checkCurrentUnit,
      invoice_data: invoice_data ?? this.invoice_data,
      buttonEnable: buttonEnable ?? this.buttonEnable,
      loading: loading ?? this.loading,
      whatPage: whatPage ?? this.whatPage,
      writeCondition: writeCondition ?? this.writeCondition,
    );
  }

  @override
  List<Object> get props => [
        countForReset,
        writeRecordId,
        customerName,
        address,
        waterNumber,
        bill_data,
        checkBilPrint,
        statebillID,
        areaNumber,
        meterNumber,
        previousUnitFormat,
        invoices,
        checkCurrentUnit,
        invoice_data,
        lat,
        lng,
        loading,
        whatPage,
        writeCondition,
        buttonEnable
      ];
}
