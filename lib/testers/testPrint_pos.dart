// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
// import 'package:flutter/material.dart';
// // import 'package:zebrautility/ZebraPrinter.dart';
// // import 'package:zebrautility/zebrautility.dart';
// // import 'package:zsdk/zsdk.dart';

// void main(List<String> args) {
//   runApp(printTest());
// }

// class printTest extends StatefulWidget {
//   printTest({Key? key}) : super(key: key);

//   @override
//   State<printTest> createState() => _printTestState();
// }

// class _printTestState extends State<printTest> {
//   PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
//   List<PrinterBluetooth> _devices =  [];
 
//   void initPrinter() {
//     _printerManager.startScan(Duration(seconds: 5));
//     _printerManager.scanResults.listen((val) {
//       print('scan: '+val.toString());
//       if(!mounted) return;
//       setState(() {
//         _devices = val;
//       });
//       print(_devices);
   
//     });
//   }

//   @override
//   void initState() {
//     initPrinter();
//     super.initState();
//   }

//   // final zsdk = ZSDK();
//   // x() {
//   //   zsdk.doManualCalibrationOverTCPIP(
//   //     address: '10.0.0.100',
//   //   );
//   // }

//   // y() {
//   //   zsdk
//   //       .getPrinterSettingsOverTCPIP(address: '10.0.0.100')
//   //       .then((value) => null);
//   // }

//   // Future<ZebraPrinter> zebraPrinter = Zebrautility.getPrinterInstance(
//   //   onPrinterFound: (name, ipAddress, isWifi) {
//   //     print(name + ' ' + ipAddress);
//   //   },
//   //   onPrinterDiscoveryDone: () {
//   //     print('found');
//   //   },
//   //   onChangePrinterStatus: (status, color) {
//   //     print('status' + status + ' ' + color);
//   //   },
//   //   onPermissionDenied: () {
//   //     print('permission denied');
//   //   },
//   // );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(

//       home: Scaffold(
//         backgroundColor: Colors.blueGrey[50],
//         appBar: AppBar(
//           title: new Text("test printer"),
//           backgroundColor: Color.fromARGB(255, 169, 191, 207),
       
//         ),
//         body: _devices.isEmpty 
//         ? Center(child: Text('no devices'),)
        
//         : ListView.builder(
//           itemCount: _devices.length,
//           itemBuilder: ((context, index) {
//           return ListTile(title: Text(_devices[index].name.toString()),);
//         }))


        
    
//       ),
//     );
//   }
// }
