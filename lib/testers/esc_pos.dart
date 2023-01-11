import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(printTest());
}

class printTest extends StatefulWidget {
  printTest({Key? key}) : super(key: key);

  @override
  State<printTest> createState() => _printTestState();
}

class _printTestState extends State<printTest> {
  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];

  void initPrinter() {
    _printerManager.startScan(Duration(seconds: 5));
    _printerManager.scanResults.listen((val) {
      print('scan: ' + val.toString());
      if (!mounted) return;
      setState(() {
        _devices = val;
      });
      print(_devices);
    });
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
                  child: Text('no devices'),
                )
              : ListView.builder(
                  itemCount: _devices.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title:
                          InkWell(

                            onTap: (){
                              
                            },
                            
                            child: Text(_devices[index].name.toString())),
                    );
                  }))),
    );
  }
}
