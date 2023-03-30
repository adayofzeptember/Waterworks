import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waterworks/blue_thermal_printer/invoice_zpl.dart';
import '../models/invoice_to_printer.dart';

class Print_Thermal_Page extends StatefulWidget {
  final ToInvoice invoideModel;

  String checkWaterWrong;
  Print_Thermal_Page(
      {Key? key, required this.invoideModel, required this.checkWaterWrong})
      : super(key: key);
  _Print_Thermal_PageState createState() => new _Print_Thermal_PageState();
}

class _Print_Thermal_PageState extends State<Print_Thermal_Page> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;
  PrintHereFucker toPrint = PrintHereFucker();

  @override
  void initState() {
    checkBluetooth();

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  if (_connected == true) {
                    _disconnect();
                  }
                  Navigator.pop(context);
                  // context
                  //     .read<WritePageBloc>()
                  //     .add(CountForReset(context: context));
                },
                child: const SizedBox(
                    width: 50,
                    height: 50,
                    child:
                        Icon(Icons.arrow_back_ios_new, color: Colors.white))),
            const SizedBox(
              width: 55,
            ),
            const Text(
              'พิมพ์เอกสาร',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(width: 10),
                    const Text(
                      'เครื่องพิมพ์: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton(
                      items: _getDeviceItems(),
                      onChanged: (BluetoothDevice? value) {
                        print(value!.address.toString());
                        setState(() {
                          _device = value;
                        });
                      },
                      value: _device,
                    ),
                    const SizedBox(width: 10),
                    (_device == null)
                        ? Container()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary:
                                    _connected ? Colors.red : Colors.green),
                            onPressed: _connected ? _disconnect : _connect,
                            child: Text(
                              _connected ? 'ยกเลิก' : 'เชื่อมต่อ',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(primary: Colors.blue),
            //   onPressed: () {
            //     initPlatformState();
            //   },
            //   child: const Text(
            //     'Refresh',
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
            (_device == null)
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('กรุณาเลือกเครื่องพิมพ์',
                          style: TextStyle(fontSize: 20, color: Colors.red)),
                    ],
                  )
                : 
                _connected
                ?Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                      onPressed: () {  
                        toPrint.printInvoice_Now(widget.invoideModel,
                            widget.checkWaterWrong.toString());
                      },
                      child: const Text('พิมพ์เอกสาร',
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                  : Container()
          ],
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

  //! connectr // แลัวปริ้นต์
  void _connect() {
    if (_device != null) {
      print(_device!.address.toString());
      bluetooth.isConnected.then((isConnected) {
        if (isConnected == false) {
          bluetooth.connect(_device!).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
        // toPrint.printInvoice_Now(
        //     widget.invoideModel, widget.checkWaterWrong.toString());
      });
      // toPrint.printInvoice_Now(
      //     widget.invoideModel, widget.checkWaterWrong.toString());
    } else {
      show('No device selected.');
    }
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
