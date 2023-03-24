part of 'write_page_bloc.dart';

class WritePageState extends Equatable {
  WritePageState({
    required this.writeRecordId,
    required this.customerName,
    required this.address,
    required this.waterNumber,
    required this.areaNumber,
    required this.meterNumber,
    required this.previousUnitFormat,
    required this.invoices,
    required this.checkCurrentUnit,
    required this.invoice_data,
    required this.loading,
    required this.whatPage,
  });
  String writeRecordId;
  String customerName, address, waterNumber, areaNumber, meterNumber;
  String previousUnitFormat;
  dynamic invoices;
  dynamic invoice_data;
  bool loading;
  String whatPage;

  bool checkCurrentUnit;
  WritePageState copyWith({
    String? writeRecordId,
    String? customerName,
    String? address,
    String? waterNumber,
    String? areaNumber,
    String? meterNumber,
    String? previousUnitFormat,
    String? statusMeter,
    dynamic invoices,
    bool? checkCurrentUnit,
    dynamic? invoice_data,
    bool? loading,
    String? whatPage,
  }) {
    return WritePageState(
      writeRecordId: writeRecordId ?? this.writeRecordId,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      waterNumber: waterNumber ?? this.waterNumber,
      areaNumber: areaNumber ?? this.areaNumber,
      meterNumber: meterNumber ?? this.meterNumber,
      previousUnitFormat: previousUnitFormat ?? this.previousUnitFormat,
      invoices: invoices ?? this.invoices,
      checkCurrentUnit: checkCurrentUnit ?? this.checkCurrentUnit,
      invoice_data: invoice_data ?? this.invoice_data,
      loading: loading ?? this.loading,
      whatPage: whatPage ?? this.whatPage,
    );
  }

  @override
  List<Object> get props => [
        writeRecordId,
        customerName,
        address,
        waterNumber,
        areaNumber,
        meterNumber,
        previousUnitFormat,
        invoices,
        checkCurrentUnit,
        invoice_data,
        loading,
        whatPage,
      ];
}
