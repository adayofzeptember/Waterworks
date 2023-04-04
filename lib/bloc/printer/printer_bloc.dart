import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:equatable/equatable.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {


  PrinterBloc() : super(PrinterState()) {
    on<ChoosePrinter>((event, emit) {
      emit(state.copyWith(printer_device: event.get_printer_value));
      print('state.printer_device');
    });
  }
}
