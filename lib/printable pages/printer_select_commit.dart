// import 'dart:convert';
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

// //'^XA^FO50,60^A0,40^FDWorlds Best Griddle^FS^XZ',
// void main(List<String> args) {
//   String credentials = "กก";
//   Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
//   String encoded =
//       stringToBase64Url.encode(credentials); // dXNlcm5hbWU6cGFzc3dvcmQ=
//   String decoded = stringToBase64Url.decode(encoded);

//   print(encoded);

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
//     String lol = 'eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee';
//     final Generator ticket = Generator(paper, profile);
//     List<int> bytes = [];

//     bytes += ticket.setGlobalCodeTable('CP874');
//     String x = "ครม";
//     List<int> j = encodeTIS620(x);
//     String l = decodeTis620(j);
//     print(x + j.toString() + l);

//     String zzz =
//         "^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ^XA^MMT^PW575^LL0559^LS0^FT166,176^A@N,28,26,angsana.fnt^FH\^FH\^CI17^F8^FD^FS^CI0^FT26,176^A@N,28,22,angsana.fnt^FH\^FH\^CI17^F8^FD${x + j.toString() + l}^FS^CI0^FO3,6^GB571,0,1^FS^FO3,552^GB571,0,1^FS^PQ1,0,1,Y^XZ";
//     String zplData =
//         "^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ^XA^MMT^PW575^LL0480^LS0^FO64,32^GFA,01792,01792,00028,:Z64:eJxjYBgFo2AUEARMeOSYUbkGyBw2KC3hAFb5AS6RyMBgAWWqgOVYBOByExkYPGByDSCSH6FvEkJOHmo0XK4GzXKSgZxBhQyHjfMEhg8yzQeK+ByPWBgaFCh8BMspF/aoSVxuKWCWUO5J6BM8rOPjaTAj2Q8sp53Ioybxg42BScKAweCABLMOj9eGGckPIHINPHIS9owHGCT42A0s2JnO8FRtqEj4A5aTduBhk5BsSGCQYObcwMPYyMMjtUEiIQ0sx5yAItdwhkcGmxw7UK6Zh0emACFnw/ZDsvEBQwU/4wYbdrCc9AOYnA/7EsmmBIYZwowbfDjBcnIToHIOPmwqCLlGCR4JAwmoHPsBCzawHwr4GB5YsDN8AMlB/TAKhjAAALDjSto=:01E3^FO67,4^GB338,8,8^FS^FO46,468^GB338,8,8^FS^PQ1,0,1,Y^XZ";
//     bytes += ticket.text(zzz, styles: PosStyles(codeTable: 'CP874'));

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

// encodeTIS620(String text) {
//   List<int> result = [];
//   for (int i = 0; i < text.length; i++) {
//     int codeUnit = text.codeUnitAt(i);
//     if (codeUnit >= 3584 && codeUnit <= 3711) {
//       // TIS-620 encoding for Thai characters
//       result.add(codeUnit - 3456);
//     } else {
//       // Other characters
//       result.add(codeUnit);
//     }
//   }
//   return result;
// }

// String decodeTis620(List<int> tis620Encoded) {
//   String utf8String = latin1.decode(tis620Encoded);
//   return utf8String;
// }
