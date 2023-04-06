import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/blue_thermal_printer/formatInvoice_zpl.dart';
import '../bloc/printer_connect/printer_connect_bloc.dart';
import '../models/invoice_to_printer.dart';
import '../screens/First_Page_bottomBar.dart';

class Print2 extends StatefulWidget {
  final ToInvoice invoideModel;

  String checkWaterWrong;
  Print2({Key? key, required this.invoideModel, required this.checkWaterWrong})
      : super(key: key);
  _Print2State createState() => new _Print2State();
}

class _Print2State extends State<Print2> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;
  late BluetoothDevice getD;

  bool _isButtonDisabled = true;
  PrintHereFucker toPrint = PrintHereFucker();

  @override
  void initState() {

    print('ความปกติ: ' + widget.checkWaterWrong);
    initPlatformState();
    super.initState();
  }

  Future<void> checkBluetooth() async {
    BluetoothEnable.enableBluetooth.then((result) {
      if (result == "true") {
        initPlatformState();
      } else if (result == "false") {}
    });
  }

  Future<void> initPlatformState() async {
    var statusLocation = Permission.location;
    if (await statusLocation.isGranted != true) {
      await Permission.location.request();
      await Permission.bluetooth.request();
      Permission.bluetooth.isGranted;
      Permission.location.isGranted;
    }
    if (await statusLocation.isGranted) {
      Permission.location.isGranted;
    } else {
      Permission.location.isGranted;
    }
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            print("bluetooth device state: connected");
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnect requested");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning off 55555");
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth off  5555");
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth on");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning on");
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            print("bluetooth device state: error");
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected == true) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text('ทดสอบ'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);

                //context.read<PrinterConnectBloc>().add(ClearName_Address());
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            )),
        body: BlocBuilder<PrinterConnectBloc, PrinterConnectState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  (state.printer_address.toString() == '' &&
                          state.printer_address.toString() == '')
                      ? Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(width: 10),
                                const Text(
                                  'เครื่องพิมพ์: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(width: 10),
                                DropdownButton(
                                  items: _getDeviceItems(),
                                  onChanged: (BluetoothDevice? value) {
                                    setState(() {
                                      _device = value;
                                    });
                                  },
                                  value: _device,
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: (() {
                                _connect(_device!.name.toString(),
                                    _device!.address.toString());
                              }),
                              child: Text(
                                'เชื่อมต่อ',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      //! มีอุปกรณ์แล้ว
                      : Column(
                          children: [
                            Text(state.printer_name.toString() +
                                state.printer_address.toString()),
                            ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                 bluetooth.disconnect();
                                // context
                                //     .read<PrinterConnectBloc>()
                                //     .add(ClearName_Address());
                              },
                              child: Text(
                                'ยกเลิก',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.brown),
                              onPressed: () {
                                // _connectBloc(state.printer_name.toString(),
                                //     state.printer_address.toString());

                                    _connect_then_Print(state.printer_name.toString(),
                                    state.printer_address.toString());
                              },
                              child: Text(
                                'พิมพ์',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text('ยังไม่ได้เปิดบลูธูท'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name ?? ""),
          value: device,
        ));
      });
    }
    return items;
  }

Future _connect_then_Print(String ptName_bloc, ptAddress_bloc) async {
  _connectBloc(ptName_bloc, ptAddress_bloc);
  await Future.delayed(const Duration(seconds: 5), () {
    print('object');
    toPrint.printInvoice_Now(
        widget.invoideModel, widget.checkWaterWrong.toString());
  });
  _waitlittleshit();
}

  Future _waitlittleshit() async {
    await Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isButtonDisabled = !_isButtonDisabled;
      });
      _disconnect();
    });
  }

  //! connect // แลัวปริ้นต์
  _connect(String ptName, ptAddress) {
    context.read<PrinterConnectBloc>().add(
        GetName_Address(getPrinterName: ptName, getPrinterAddress: ptAddress));
    // if (_device != null) {
    //   print(ptName + ptAddress);

    //   bluetooth.isConnected.then((isConnected) {
    //     if (isConnected == false) {
    //       bluetooth.connect(_device!).catchError((error) {});
    //     }
    //   });
    // } else {
    //   show('No device selected.');
    // }
  }

  _connectBloc(String ptName_bloc, ptAddress_bloc) {
    print(ptName_bloc + ' ' + ptAddress_bloc);
    getD = BluetoothDevice(ptName_bloc, ptAddress_bloc);
    bluetooth.isConnected.then((isConnected) {
        if (isConnected == false) {
          bluetooth.connect(getD).catchError((error) {});
        }
      });
    // if (_device != null) {
    //   bluetooth.isConnected.then((isConnected) {
    //     if (isConnected == false) {
    //       bluetooth.connect(getD).catchError((error) {});
    //     }
    //   });
    // } else {
    //   show('No device selected.');
    // }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = false);
  }

  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: duration,
      ),
    );
  }
}
