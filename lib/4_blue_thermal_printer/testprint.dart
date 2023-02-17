import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:waterworks/4_blue_thermal_printer/enum.dart';

///Test printing
class TestPrint {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample() async {

    ByteData bytesAsset = await rootBundle.load("assets/images/person.png");
    Uint8List imageBytesFromAsset = bytesAsset.buffer
        .asUint8List(bytesAsset.offsetInBytes, bytesAsset.lengthInBytes);


    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
String x = 'หหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหหห';
                    String text = """"

^XA
^MMT
^PW575
^LL0639
^LS0
^FO160,0^GFA,01920,01920,00020,:Z64:
eJzt0D1qwzAUB3BJz5VdMDSjhpBAyAFeNw+hU+g5RLN20Jihg6El+Dg5goaic5hOGZ0LhOjDpKqtoUOhi/+DPn6gJz0RMuU/kiXsc0x0/Tsjp4Tt4w2GSbkBWr+eWxO2nnabvPO2ChZS4tiKhN0HW8hg/o7i6I331sSmI8vD2bs6lGqixz6Q6M29VT86xETXuAHGaEfbpV6Anm28PQPnXDCUapdJNDfLSoYa6YdEuFnBGdbi256swYGe54K+t71xd9aQx5WgtRzYy8DAzPBrYMQIfBtZiXJkPGEQW8Uhz60dne06b1sORVMb2jl7bWIj3vaxbYlypoJVy4utVwWTChJfPGXKlD/JFUqDSkc=:269D
^FT117,250^A@N,28,26,angsana.fnt
^FH\
^FH\^CI17^F8^FDเทศบาลนครราชสีมา^FS^CI0
^FT117,481^A@N,28,26,angsana.fnt
^FH\
^FH\^CI17^F8^FD${x}^FS^CI0
^PQ1,0,1,Y^XZ
""";
       
        bluetooth.printCustom(text, Size.boldMedium.val, Align.center.val);
       
        bluetooth
            .paperCut(); 
      }
    });
  }

}


























