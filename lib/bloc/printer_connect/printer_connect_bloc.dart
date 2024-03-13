// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'printer_connect_event.dart';
part 'printer_connect_state.dart';

class PrinterConnectBloc
    extends Bloc<PrinterConnectEvent, PrinterConnectState> {
  PrinterConnectBloc()
      : super(PrinterConnectState(
            printer_name: '', printer_address: '', printer_isConnect: false)) {
    on<GetName_Address>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('printer_name', event.getPrinterName);
      prefs.setString('printer_address', event.getPrinterAddress);
      emit(state.copyWith(
          printer_name: event.getPrinterName,
          printer_address: event.getPrinterAddress));
    });

    on<Load_Printer>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? printer_name = prefs.getString('printer_name').toString();
      String? printer_address = prefs.getString('printer_address').toString();

      if (printer_name != null && printer_address != null) {
        emit(state.copyWith(
            printer_name: printer_name, printer_address: printer_address));
      }
    });

    on<ClearName_Address>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('printer_name');
      prefs.remove('printer_address');
      emit(state.copyWith(printer_name: '', printer_address: ''));
    });

    //* connecting

    on<CheckPrinter_Connect>((event, emit) async {
      emit(state.copyWith(printer_isConnect: event.getCheckIsPrinterConnect));
      print('BT connect: '+state.printer_isConnect.toString());
    });

    // on<Printer_IsNotConnect>((event, emit) async {
    //   emit(state.copyWith(printer_isConnect: false));
    //   print(state.printer_isConnect.toString());
    // });
  }
}
