import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:image/image.dart' as Imag;
import 'package:waterworks/ETC/model.dart';

void main(List<String> args) {
  runApp(MyApp_Printer());
}

class MyApp_Printer extends StatefulWidget {
  @override
  MyApp_Printer({Key? key}) : super(key: key);

  _MyApp_PrinterState createState() => _MyApp_PrinterState();
}

class _MyApp_PrinterState extends State<MyApp_Printer> {
  String _info = "";
  String _msj = '';
  bool connected = false;

  String _selectSize = "2";

  @override
  void initState() {
    super.initState();
    connect('F4:60:77:38:CC:8E');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('พิมพ์เอกสาร'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: disconnect,
                      child: Text("กลับ"),
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: printNow,
                    child: Text("พิมพ์เอกสาร"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> connect(String mac) async {
    setState(() {});
    final bool result =
        await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    print("state conected $result");
    if (result) connected = true;
    setState(() {});
  }

  Future<void> disconnect() async {
    final bool status = await PrintBluetoothThermal.disconnect;
    setState(() {
      connected = false;
    });
    print("status disconnect $status");
    Navigator.pop(context);
  }

  Future<void> printNow() async {
    String x = "ครม";
    List<int> j = encodeTIS620(x);
    String l = decodeTis620(j);
    print(x + j.toString() + l);
 

    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    if (connectionStatus) {
      String text = """"
^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ
^XA
^MMT
^PW575
^LL0400
^LS0
^FT7,275^A@N,283,146,angsana.fnt
^FH\
^FH\^CI17^F8^FD555555:^FS^CI0
^PQ1,0,1,Y^XZ
""";

      bool result = await PrintBluetoothThermal.writeString(
          printText: PrintTextSize(size: int.parse(_selectSize), text: text));
      print("status print result: $result");
      setState(() {
        encodeTIS620('text');
        _msj = "printed status: $result";
      });
    } else {
      setState(() {
        _msj = "no connected device";
      });
    }
  }
}

encodeTIS620(String text) {
  List<int> result = [];
  for (int i = 0; i < text.length; i++) {
    int codeUnit = text.codeUnitAt(i);
    if (codeUnit >= 3584 && codeUnit <= 3711) {
      // TIS-620 encoding for Thai characters
      result.add(codeUnit - 3456);
    } else {
      // Other characters
      result.add(codeUnit);
    }
  }
  return result;
}

String decodeTis620(List<int> tis620Encoded) {
  String utf8String = latin1.decode(tis620Encoded);
  return utf8String;
}
