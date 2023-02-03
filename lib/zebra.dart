import 'package:flutter/material.dart';
import 'package:zebrautility/ZebraPrinter.dart';
import 'package:zebrautility/zebrautility.dart';

void main(List<String> args) {
  runApp(ZebreaUtiltty());
}

class ZebreaUtiltty extends StatefulWidget {
  ZebreaUtiltty({Key? key}) : super(key: key);

  @override
  State<ZebreaUtiltty> createState() => _ZebreaUtilttyState();
}

class _ZebreaUtilttyState extends State<ZebreaUtiltty> {
  late ZebraPrinter zebraPrinter;
  @override
  void initState() {
    super.initState();
    zebraInitial();
  }

  Future<void> zebraInitial() async {
    ZebraPrinter zebraPrinter = await Zebrautility.getPrinterInstance(
        onPrinterFound: onPrinterFound('ประปา t', 'F4:60:77:38:CC:8E', false),
        onPrinterDiscoveryDone: onPrinterDiscoveryDone,
        onChangePrinterStatus: onChangePrinterStatus(),
        onPermissionDenied: onPermissionDenied);
    zebraPrinter.connectToPrinter("F4:60:77:38:CC:8E");
  }

  Function onPrinterFound = (String name, String ipAddress, bool isWifi) {
    print("PrinterFound :" + name + ipAddress);
  };

  Function onPrinterDiscoveryDone = () {
    print("Discovery Done");
  };

  Function onChangePrinterStatus = (status, color) {
    print("change printer status: " + status + color);
  };

  Function onPermissionDenied = () {
    print("Permission Deny.");
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [Text('data Loader')],
        ),
      ),
    );
  }
}
