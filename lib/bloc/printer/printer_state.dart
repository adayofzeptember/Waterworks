part of 'printer_bloc.dart';

class PrinterState extends Equatable {
  dynamic printer_device;


  PrinterState({this.printer_device});

  
  PrinterState copyWith({BluetoothDevice? printer_device}) {
    return PrinterState(
        printer_device:printer_device!);
      
  }

  
  @override
  List<Object> get props => [printer_device];
}


