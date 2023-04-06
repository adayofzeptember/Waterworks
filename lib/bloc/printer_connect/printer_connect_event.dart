part of 'printer_connect_bloc.dart';

abstract class PrinterConnectEvent extends Equatable {
  const PrinterConnectEvent();

  @override
  List<Object> get props => [];
}


class GetName_Address extends PrinterConnectEvent {
  String getPrinterName;
  String getPrinterAddress;

  GetName_Address({
    required this.getPrinterName,
    required this.getPrinterAddress
  });
}


class ClearName_Address extends PrinterConnectEvent {
}