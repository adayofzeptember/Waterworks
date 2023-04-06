import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'printer_connect_event.dart';
part 'printer_connect_state.dart';

class PrinterConnectBloc
    extends Bloc<PrinterConnectEvent, PrinterConnectState> {
  PrinterConnectBloc()
      : super(PrinterConnectState(printer_name: '', printer_address: '')) {
    on<GetName_Address>((event, emit) {
      emit(state.copyWith(
          printer_name: event.getPrinterName,
          printer_address: event.getPrinterAddress));
    });

    on<ClearName_Address>((event, emit) {
      emit(state.copyWith(printer_name: '', printer_address: ''));
    });
  }
}
