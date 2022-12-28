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

  Future<void> initPrinter3() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));
    if(!mounted) return;
    bluetoothPrint.scanResults.listen((val) {
      if(!mounted) return;
      setState(() {
        _devices = val;
      });
      print(_devices);
      if(_devices.isEmpty){
        _devicesMsg = 'no devices';
      }
     });
  }

  @override
  void initState() {
    initPrinter3();
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
          body: _devices.isEmpty ? Center(child: Text(_devicesMsg ??  'sdasd'),)
          : ListView.builder(
            itemCount: _devices.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(_devices[index].name.toString()),);
            },)
          ),
    );
  }
}
