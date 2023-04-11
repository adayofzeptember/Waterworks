part of 'printer_connect_bloc.dart';

abstract class PrinterConnectEvent extends Equatable {
  const PrinterConnectEvent();

  @override
  List<Object> get props => [];
}

class GetName_Address extends PrinterConnectEvent {
  String getPrinterName;
  String getPrinterAddress;

  GetName_Address(
      {required this.getPrinterName, required this.getPrinterAddress});
}

class CheckPrinter_Connect extends PrinterConnectEvent {
  bool getCheckIsPrinterConnect;
  // ประกาศค่าเพราะต้องการค่าที่ส่งมาจาก UI
  CheckPrinter_Connect({required this.getCheckIsPrinterConnect});
}

class Printer_IsNotConnect extends PrinterConnectEvent {
  // ไม่ต้องประกาศค่าเพราะไม่ต้องการค่าที่ส่งมาจาก UI 
  // เซ็ทค่าเองได้เลยใน bloc

}


class ClearName_Address extends PrinterConnectEvent {}

class Load_Printer extends PrinterConnectEvent {}
