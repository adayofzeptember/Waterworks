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
  });
  String writeRecordId;
  String customerName, address, waterNumber, areaNumber, meterNumber;
  String previousUnitFormat;
  dynamic invoices;

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
      ];
}
