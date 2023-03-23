import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:waterworks/blue_thermal_printer/print_setting.dart';
import 'package:waterworks/models/invoice_to_printer.dart';

class PrintHereFucker {
  printInvoice_Now(ToInvoice thisInvoice, String check) async {
    print('หน้าปริ้น ฟังชั่นปริ้น' + check);
    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        String zplToPrinter = "";
        if (check == "1") {
          zplToPrinter = "^XA^MD20^FO50,50^A0N,50,50^FDHello World!^FS^XZ";
        }
               
        bluetooth.printCustom(
            zplToPrinter, Size.boldMedium.val, Align.center.val);
        bluetooth.paperCut();
      }
    });
  }
} 
