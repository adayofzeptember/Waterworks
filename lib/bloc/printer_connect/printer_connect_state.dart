part of 'printer_connect_bloc.dart';
// ignore_for_file: must_be_immutable
class PrinterConnectState extends Equatable {
  String printer_name;
  String printer_address;
  bool printer_isConnect;

  PrinterConnectState(
      {required this.printer_name,
      required this.printer_address,
      required this.printer_isConnect});

  PrinterConnectState copyWith(
      {String? printer_name, String? printer_address, bool? printer_isConnect}) {
    return PrinterConnectState(
        printer_isConnect: printer_isConnect ?? this.printer_isConnect,
        printer_name: printer_name ?? this.printer_name,
        printer_address: printer_address ?? this.printer_address);
  }

  @override
  List<Object> get props => [printer_name, printer_address, printer_isConnect];
}
