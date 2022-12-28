import 'package:flutter/material.dart';

import 'package:zsdk/zsdk.dart';

void main(List<String> args) {
  runApp(printTest_Zebra());
}

final zsdk = ZSDK();

class printTest_Zebra extends StatefulWidget {
  printTest_Zebra({Key? key}) : super(key: key);

  @override
  State<printTest_Zebra> createState() => _printTest_ZebraState();
}

class _printTest_ZebraState extends State<printTest_Zebra> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            title: new Text("test printer"),
            backgroundColor: Color.fromARGB(255, 169, 191, 207),
          ),
          body: Column(
            children: [],
          )),
    );
  }
}

printerCalibration1() {
  zsdk.doManualCalibrationOverTCPIP(
    address: '10.0.0.100',
    port: 9100,
  );
}

getPrinterSettings() {
  zsdk.getPrinterSettingsOverTCPIP(address: '10.0.0.100').then((value) {
    final printerSettings = PrinterResponse.fromMap(value).settings;
  });
}

setPinter() {
  zsdk
      .setPrinterSettingsOverTCPIP(
          address: '10.0.0.100',
          port: 9100,
          settings: PrinterSettings(
            darkness: 10,
            printSpeed: 6,
            tearOff: 0,
            mediaType: MediaType.MARK,
            printMethod: PrintMethod.DIRECT_THERMAL,
            printWidth: 568,
            labelLength: 1202,
            labelLengthMax: 39,
            zplMode: ZPLMode.ZPL_II,
            powerUpAction: PowerUpAction.NO_MOTION,
            headCloseAction: HeadCloseAction.NO_MOTION,
            labelTop: 0,
            leftPosition: 0,
            printMode: PrintMode.TEAR_OFF,
            reprintMode: ReprintMode.OFF,
          ))
      .then((value) {
    final printerResponse = PrinterResponse.fromMap(value);
    if (printerResponse.errorCode == ErrorCode.SUCCESS) {
    } else {
      Status status = printerResponse.statusInfo.status;
      Cause cause = printerResponse.statusInfo.cause;
    }
  });
}

resetPrinter() {
  zsdk
      .setPrinterSettingsOverTCPIP(
          address: '10.0.0.100',
          port: 9100, //optional
          settings: PrinterSettings.defaultSettings())
      .then((value) {
    final printerResponse = PrinterResponse.fromMap(value);
    if (printerResponse.errorCode == ErrorCode.SUCCESS) {
    } else {
      Status status = printerResponse.statusInfo.status;
      Cause cause = printerResponse.statusInfo.cause;
    }
  });
}

checkStatus() {
  zsdk
      .checkPrinterStatusOverTCPIP(
    address: '10.0.0.100',
    port: 9100, //optional
  )
      .then((value) {
    final printerResponse = PrinterResponse.fromMap(value);
    Status status = printerResponse.statusInfo.status;
    print(status);
    if (printerResponse.errorCode == ErrorCode.SUCCESS) {
      //Do something
    } else {
      Cause cause = printerResponse.statusInfo.cause;
      print(cause);
    }
  });
}
