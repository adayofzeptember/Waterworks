// import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:waterworks/ETC/color_green.dart';
// import 'package:waterworks/blue_thermal_printer/formatInvoice_zpl.dart';
// import '../shapes_painter.dart';
// import '../../bloc/printer_connect/printer_connect_bloc.dart';
// import '../../models/invoice_to_printer.dart';
// import '../../screens/First_Page_bottomBar.dart';

// class Print3 extends StatefulWidget {
//   final ToInvoice invoideModel;

//   String checkWaterWrong;
//   String? debt;

//   Print3(
//       {Key? key,
//       required this.invoideModel,
//       required this.checkWaterWrong,
//       this.debt})
//       : super(key: key);
//   _Print3State createState() => new _Print3State();
// }

// class _Print3State extends State<Print3> {
//   BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
//   List<BluetoothDevice> _devices = [];
//   BluetoothDevice? _device;
//   bool _connected = false;
//   late BluetoothDevice getD;
//   bool _isButtonDisabled = true;
//   PrintHereFucker toPrint = PrintHereFucker();

//   @override
//   void initState() {
//     context.read<PrinterConnectBloc>().add(Load_Printer());
//     print('ความปกติ: ' + widget.checkWaterWrong);
//     print(widget.invoideModel.inv_barcode);
//     initPlatformState();

//     super.initState();
//   }

//   Future<void> checkBluetooth() async {
//     BluetoothEnable.enableBluetooth.then((result) {
//       if (result == "true") {
//         initPlatformState();
//       } else if (result == "false") {}
//     });
//   }

//   Future<void> initPlatformState() async {
//     var statusLocation = Permission.location;
//     if (await statusLocation.isGranted != true) {
//       await Permission.location.request();
//       await Permission.bluetooth.request();
//       Permission.bluetooth.isGranted;
//       Permission.location.isGranted;
//     }
//     if (await statusLocation.isGranted) {
//       Permission.location.isGranted;
//     } else {
//       Permission.location.isGranted;
//     }
//     bool? isConnected = await bluetooth.isConnected;
//     List<BluetoothDevice> devices = [];
//     try {
//       devices = await bluetooth.getBondedDevices();
//     } on PlatformException {}

//     bluetooth.onStateChanged().listen((state) {
//       switch (state) {
//         case BlueThermalPrinter.CONNECTED:
//           setState(() {
//             _connected = true;
            
//             print("bluetooth device state: connected");
//           });
//           break;
//         case BlueThermalPrinter.DISCONNECTED:
//           context
//               .read<PrinterConnectBloc>()
//               .add(CheckPrinter_Connect(getCheckIsPrinterConnect: false));

//           setState(() {
//             _connected = false;
//             print("bluetooth device state: disconnected");
//           });
//           break;
//         case BlueThermalPrinter.DISCONNECT_REQUESTED:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: disconnect requested");
//           });
//           break;
//         case BlueThermalPrinter.STATE_TURNING_OFF:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: bluetooth turning off 55555");
//           });
//           break;
//         case BlueThermalPrinter.STATE_OFF:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: bluetooth off  5555");
//           });
//           break;
//         case BlueThermalPrinter.STATE_ON:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: bluetooth on");
//           });
//           break;
//         case BlueThermalPrinter.STATE_TURNING_ON:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: bluetooth turning on");
//           });
//           break;
//         case BlueThermalPrinter.ERROR:
//           setState(() {
//             _connected = false;
//             print("bluetooth device state: error");
//           });
//           break;
//         default:
//           print(state);
//           break;
//       }
//     });

//     if (!mounted) return;
//     setState(() {
//       _devices = devices;
//     });

//     if (isConnected == true) {
//       setState(() {
//         _connected = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pop(context);
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: const Color.fromARGB(209, 0, 0, 0),
//         appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//             centerTitle: true,
//             title: const Text(
//               'ล็อค bluetooth',
//               style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
//             ),
//             leading: Row(
//               children: [
//                 IconButton(
//                   color: Palette.thisGreen,
//                   onPressed: () {
//                     Navigator.pop(context);

//                     //context.read<PrinterConnectBloc>().add(ClearName_Address());
//                   },
//                   icon: const Icon(
//                     Icons.arrow_back_ios_new,
//                   ),
//                 ),
//               ],
//             )),
//         body: MediaQuery(
//           data: MediaQuery.of(context).copyWith(
//             textScaleFactor: 1.0,
//           ),
//           child: BlocBuilder<PrinterConnectBloc, PrinterConnectState>(
//             builder: (context, state) {
//               return Stack(
//                 children: [
//                   CustomPaint(
//                     painter: ShapesPainter(),
//                     child: Container(height: 0),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(15),
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(0))),
//                     width: double.infinity,
//                     height: 200,
//                     child: Column(
//                       children: [
//                         if (state.printer_address.toString() == '' &&
//                                 state.printer_name.toString() == '' ||
//                             state.printer_address == 'null' &&
//                                 state.printer_name == 'null')
//                           Column(
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   const SizedBox(width: 10),
//                                   const Text(
//                                     'เครื่องพิมพ์: ',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20),
//                                   ),
//                                   const Icon(Icons.print_rounded),
//                                   const SizedBox(width: 2),
//                                   DropdownButton(
//                                     elevation: 0,
//                                     underline: const SizedBox(),
//                                     items: _getDeviceItems(),
//                                     onChanged: (BluetoothDevice? value) {
//                                       setState(() {
//                                         _device = value;
//                                       });
//                                     },
//                                     value: _device,
//                                   ),
//                                   const SizedBox(width: 5),
//                                   (_device == null)
//                                       ? const Icon(
//                                           Icons.arrow_back_outlined,
//                                           color: Colors.red,
//                                         )
//                                       : Container()
//                                 ],
//                               ),
//                               (_device == null)
//                                   ? Column(
//                                       children: [
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         const Text('กรุณาเลือกเครื่องพิมพ์',
//                                             style: TextStyle(
//                                                 fontSize: 20,
//                                                 color: Colors.red,
//                                                 fontWeight: FontWeight.bold)),
//                                       ],
//                                     )
//                                   : ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           primary: Colors.green),
//                                       onPressed: (() {
//                                         context.read<PrinterConnectBloc>().add(
//                                             GetName_Address(
//                                                 getPrinterName:
//                                                     _device!.name.toString(),
//                                                 getPrinterAddress: _device!
//                                                     .address
//                                                     .toString()));
//                                         // _connectFirstTime(_device!.name.toString(),
//                                         //     _device!.address.toString());
//                                       }),
//                                       child: const Text(
//                                         'ตกลง',
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 20),
//                                       ),
//                                     ),
//                             ],
//                           )
//                         else if (state.printer_isConnect == true)
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               primary: _isButtonDisabled
//                                   ? Palette.thisGreen
//                                   : const Color.fromARGB(255, 155, 153, 153),
//                             ),
//                             onPressed: _isButtonDisabled
//                                 ? () {
//                                     setState(() {
//                                       _isButtonDisabled = !_isButtonDisabled;
//                                     });
//                                     // _connectBloc(state.printer_name.toString(),
//                                     //     state.printer_address.toString());

//                                     _connect_then_Print(
//                                         state.printer_name.toString(),
//                                         state.printer_address.toString());
//                                   }
//                                 : null,
//                             child: Text(
//                               _isButtonDisabled
//                                   ? 'พิมพ์ใบแจ้ง'
//                                   : 'กำลังพิมพ์ใบแจ้ง..',
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 20),
//                             ),
//                           )
//                         else
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.print_rounded,
//                                     size: 40,
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text(
//                                     state.printer_name.toString(),
//                                     style: const TextStyle(fontSize: 20),
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   const Icon(
//                                     Icons.check_circle,
//                                     size: 20,
//                                     color: Colors.green,
//                                   ),
//                                 ],
//                               ),
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Palette.thisGreen,
//                                 ),
//                                 onPressed: () {
//                                   _connect_fromBloc(
//                                       state.printer_name.toString(),
//                                       state.printer_address.toString());
//                                 },
//                                 child: Text(
//                                   'เชื่อมต่อ',
//                                   style: const TextStyle(
//                                       color: Colors.white, fontSize: 20),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Colors.red),
//                                 onPressed: () {
//                                   _disconnect();
//                                   //_showAlertDeletePrinter(context);

//                                   // if (_connected == true) {
//                                   //   bluetooth.disconnect();
//                                   // }

//                                   // context
//                                   //     .read<PrinterConnectBloc>()
//                                   //     .add(ClearName_Address());
//                                 },
//                                 child: const Text(
//                                   'ยกเลิกการเชื่อมต่อเครื่องพิมพ์',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                               ),
//                             ],
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
//     List<DropdownMenuItem<BluetoothDevice>> items = [];
//     if (_devices.isEmpty) {
//       items.add(const DropdownMenuItem(
//         child: Text('ยังไม่ได้เปิดบลูธูท'),
//       ));
//     } else {
//       _devices.forEach((device) {
//         items.add(DropdownMenuItem(
//           child: Text(device.name ?? ""),
//           value: device,
//         ));
//       });
//     }
//     return items;
//   }

//   Future _connect_then_Print(String ptName_bloc, ptAddress_bloc) async {
//     _connect_fromBloc(ptName_bloc, ptAddress_bloc);
//     await Future.delayed(const Duration(seconds: 5), () {
//       toPrint.printInvoice_Now(widget.invoideModel,
//           widget.checkWaterWrong.toString(), widget.debt.toString());
//     });
//     await Future.delayed(const Duration(seconds: 5), () {
//       setState(() {
//         _isButtonDisabled = !_isButtonDisabled;
//       });

//       // _disconnect();
//     });

//     // _waitlittleshit();
//   }

//   _connect_fromBloc(String ptName_bloc, ptAddress_bloc) {
//     print(ptName_bloc + ' ' + ptAddress_bloc);
//     getD = BluetoothDevice(ptName_bloc, ptAddress_bloc);
//     bluetooth.isConnected.then((isConnected) {
//       if (isConnected == false) {
//         bluetooth.connect(getD).catchError((error) {});
//       }
//       context
//           .read<PrinterConnectBloc>()
//           .add(CheckPrinter_Connect(getCheckIsPrinterConnect: true));

//       setState(() {
//         _connected = true;
//       });
//     });
//   }

//   Future _waitlittleshit() async {
//     await Future.delayed(const Duration(seconds: 5), () {
//       setState(() {
//         _isButtonDisabled = !_isButtonDisabled;
//       });

//       // _disconnect();
//     });
//   }

//   void _disconnect() {
//     bluetooth.disconnect();
//     setState(() => _connected = false);
//   }

//   _showAlertDeletePrinter(var context) {
//     return showDialog(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('ยกเลิกการเชื่อมต่อเครื่องพิมพ์ ?',
//               style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Column(
//                   children: const [
//                     Text(
//                       'หากยืนยัน การพิมพ์ครั้งต่อไปจะต้องเลือกเครื่องพิมพ์ใหม่อีกครั้ง',
//                       style: TextStyle(fontSize: 25),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//    backgroundColor: Colors.green,  // Button color
//    foregroundColor: Colors.lime,   // Splash color
// ),
//               child: const Text(
//                 'ยกเลิก',
//                 style: TextStyle(color: Colors.red),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               onPressed: () {
//                 if (_connected == true) {
//                   bluetooth.disconnect();
//                 }

//                 context.read<PrinterConnectBloc>().add(ClearName_Address());
//                 Navigator.of(context).pop();
//               },
//               child: const Text('ยืนยัน'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future show(
//     String message, {
//     Duration duration: const Duration(seconds: 3),
//   }) async {
//     await new Future.delayed(new Duration(milliseconds: 100));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: const TextStyle(color: Colors.white),
//         ),
//         duration: duration,
//       ),
//     );
//   }
// }
