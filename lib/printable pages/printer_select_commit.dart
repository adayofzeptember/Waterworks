// import 'dart:io';
// import 'dart:typed_data';
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
// import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart';
// import 'package:flutter/material.dart' hide Image;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:waterworks/ETC/color_green.dart';

// void main(List<String> args) {
//   runApp(MyHomePage());
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   PrinterBluetoothManager printerManager = PrinterBluetoothManager();
//   List<PrinterBluetooth> _devices = [];

//   @override
//   void initState() {
//     grantBlue();
//     super.initState();

//     printerManager.scanResults.listen((devices) async {
//       print('UI: Devices found ${devices.length}');
//       setState(() {
//         _devices = devices;
//       });
//     });
//   }

//   Future<void> grantBlue() async {
//     final profiles = await CapabilityProfile.getAvailableProfiles();
//     print(profiles[3]);

//     for (var i = 0; i < profiles.length; i++) {
//       print(profiles[i]);
//     }

//     var statusLocation = Permission.location;
//     if (await statusLocation.isGranted != true) {
//       await Permission.location.request();
//       await Permission.bluetooth.request();
//     }
//   }

//   void _startScanDevices() {
//     setState(() {
//       _devices = [];
//     });
//     printerManager.startScan(Duration(seconds: 4));
//   }

//   void _stopScanDevices() {
//     printerManager.stopScan();
//   }

//   Future<List<int>> demoReceipt(
//       PaperSize paper, CapabilityProfile profile) async {
//     String x = 'eee';
//     final Generator ticket = Generator(paper, profile);
//     List<int> bytes = [];

//     bytes += ticket.setGlobalCodeTable('CP874');

//     String zplData = "^XA^FO290,10^A1,50,50^FDชื่อ:ธัญญพร ชูเกียรติพัฒน์^FS^XZ";
//     bytes += ticket.text(zplData, styles: PosStyles(codeTable: 'CP874'));

//     final now = DateTime.now();
//     final formatter = DateFormat('MM/dd/yyyy H:m');
//     final String timestamp = formatter.format(now);

//     bytes += ticket.text(timestamp,
//         styles: PosStyles(align: PosAlign.center), linesAfter: 2);

//     ticket.cut();
//     return bytes;
//   }

//   void _testPrint(PrinterBluetooth printer) async {
//     printerManager.selectPrinter(printer);

//     // TODO Don't forget to choose printer's paper
//     const PaperSize paper = PaperSize.mm80;
//     final profile = await CapabilityProfile.load(name: 'default');

//     final PosPrintResult res =
//         await printerManager.printTicket((await demoReceipt(paper, profile)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Row(
//             children: [
//               InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: SizedBox(
//                       width: 50,
//                       height: 50,
//                       child:
//                           Icon(Icons.arrow_back_ios_new, color: Colors.white))),
//               SizedBox(
//                 width: 55,
//               ),
//               Text(
//                 'เลือกเครื่องพิมพ์',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//         body: ListView.builder(
//             itemCount: _devices.length,
//             itemBuilder: (BuildContext context, int index) {
//               return InkWell(
//                 onTap: () => _testPrint(_devices[index]),
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       height: 60,
//                       padding: EdgeInsets.only(left: 10),
//                       alignment: Alignment.centerLeft,
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.print),
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Text(_devices[index].name ?? ''),
//                                 Text(
//                                   'เลือก',
//                                   style: TextStyle(color: Colors.grey[700]),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Divider(),
//                   ],
//                 ),
//               );
//             }),
//         floatingActionButton: StreamBuilder<bool>(
//           stream: printerManager.isScanningStream,
//           initialData: false,
//           builder: (c, snapshot) {
//             if (snapshot.data!) {
//               return FloatingActionButton(
//                 child: Icon(Icons.stop),
//                 onPressed: _stopScanDevices,
//                 backgroundColor: Colors.red,
//               );
//             } else {
//               return FloatingActionButton(
//                 backgroundColor: Palette.thisGreen,
//                 child: Icon(Icons.search),
//                 onPressed: _startScanDevices,
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
