import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
// import 'package:zebrautility/ZebraPrinter.dart';
// import 'package:zebrautility/zebrautility.dart';
// import 'package:zsdk/zsdk.dart';

void main(List<String> args) {
  runApp(printTest_3());
}

class printTest_3 extends StatefulWidget {
  printTest_3({Key? key}) : super(key: key);

  @override
  State<printTest_3> createState() => _printTest_3State();
}

class _printTest_3State extends State<printTest_3> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _devicesMsg = '';

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));
    if (!mounted) return;
    bluetoothPrint.scanResults.listen((val) {
      if (!mounted) return;
      setState(() {
        _devices = val;
      });

      print(_devices);
      if (_devices.isEmpty) {
        _devicesMsg = 'no devices';
      }
    });
  }

  Future<void> _startPrint(BluetoothDevice deviceGu) async {
    if (deviceGu != null && deviceGu.address != null) {
      await bluetoothPrint.connect(deviceGu);

      Map<String, dynamic> config = Map();
      config['width'] = 40;
      config['height'] = 50;
      config['gap'] = 2;

      List<LineText> list = [];
      list.add(
        LineText(
            type: LineText.TYPE_TEXT,
            content: "-----------------------",
            weight: 2,
            width: 2,
            height: 2,
            align: LineText.ALIGN_CENTER,
            linefeed: 1),
      );

      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: "zep--zep",
          weight: 2,
          width: 2,
          height: 2,
          align: LineText.ALIGN_RIGHT,
          linefeed: 1));
      bluetoothPrint.printTest();

       //bluetoothPrint.printLabel(config, list);
    }
  }

  @override
  void initState() {
    initPrinter();
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
          body: _devices.isEmpty
              ? Center(
                  child: Text(_devicesMsg),
                )
              : ListView.builder(
                  itemCount: _devices.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      subtitle: Text(_devices[index].address.toString()),
                      title: Text(_devices[index].name.toString()),
                      onTap: () {
                        _startPrint(_devices[index]);
                      },
                    );
                  },
                )),
    );
  }
}
