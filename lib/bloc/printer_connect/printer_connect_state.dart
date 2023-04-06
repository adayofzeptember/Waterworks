part of 'printer_connect_bloc.dart';

class PrinterConnectState extends Equatable {

  String printer_name;
  String printer_address;

  PrinterConnectState({required this.printer_name, required this.printer_address});


    PrinterConnectState copyWith({String? printer_name, String? printer_address}) {
    return PrinterConnectState(
        printer_name: printer_name ?? this.printer_name,
        printer_address : printer_address ?? this.printer_address);
  }

  
  @override
  List<Object> get props => [printer_name, printer_address];
}

