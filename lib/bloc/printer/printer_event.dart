part of 'printer_bloc.dart';

abstract class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object> get props => [];
}

class ChoosePrinter extends PrinterEvent {
  BluetoothDevice? get_printer_value;
  ChoosePrinter({
    required this.get_printer_value,
  });
}
