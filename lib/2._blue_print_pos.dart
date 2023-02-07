import 'dart:convert';
import 'dart:typed_data';
import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/models.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> _blueDevices = <BlueDevice>[];
  BlueDevice? _selectedDevice;
  bool _isLoading = false;
  int _loadingAtIndex = -1;

  @override
  void initState() {
    xT();
    super.initState();
  }

  Future<void> xT() async {
    var statusLocation = Permission.location;
    if (await statusLocation.isGranted != true) {
      await Permission.location.request();
      await Permission.bluetooth.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('test 2. Blue Print Pos'),
        ),
        body: SafeArea(
          child: _isLoading && _blueDevices.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : _blueDevices.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: List<Widget>.generate(_blueDevices.length,
                                (int index) {
                              return Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: _blueDevices[index].address ==
                                              (_selectedDevice?.address ?? '')
                                          ? _onDisconnectDevice
                                          : () => _onSelectDevice(index),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              _blueDevices[index].name,
                                              style: TextStyle(
                                                color:
                                                    _selectedDevice?.address ==
                                                            _blueDevices[index]
                                                                .address
                                                        ? Colors.blue
                                                        : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              _blueDevices[index].address,
                                              style: TextStyle(
                                                color:
                                                    _selectedDevice?.address ==
                                                            _blueDevices[index]
                                                                .address
                                                        ? Colors.blueGrey
                                                        : Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_loadingAtIndex == index && _isLoading)
                                    Container(
                                      height: 24.0,
                                      width: 24.0,
                                      margin: const EdgeInsets.only(right: 8.0),
                                      child: const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.blue,
                                        ),
                                      ),
                                    ),
                                  if (!_isLoading &&
                                      _blueDevices[index].address ==
                                          (_selectedDevice?.address ?? ''))
                                    TextButton(
                                      onPressed: _onPrintReceipt,
                                      child: Container(
                                        color: _selectedDevice == null
                                            ? Colors.grey
                                            : Colors.blue,
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text(
                                          'Test Print',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.5);
                                            }
                                            return Theme.of(context)
                                                .primaryColor;
                                          },
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            'Scan bluetooth device',
                            style: TextStyle(fontSize: 24, color: Colors.blue),
                          ),
                          Text(
                            'Press button scan',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _isLoading ? null : _onScanPressed,
          child: const Icon(Icons.search),
          backgroundColor: _isLoading ? Colors.grey : Colors.blue,
        ),
      ),
    );
  }

  Future<void> _onScanPressed() async {
    setState(() => _isLoading = true);
    _bluePrintPos.scan().then((List<BlueDevice> devices) {
      if (devices.isNotEmpty) {
        setState(() {
          _blueDevices = devices;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    });
  }

  void _onDisconnectDevice() {
    _bluePrintPos.disconnect().then((ConnectionStatus status) {
      if (status == ConnectionStatus.disconnect) {
        setState(() {
          _selectedDevice = null;
        });
      }
    });
  }

  void _onSelectDevice(int index) {
    setState(() {
      _isLoading = true;
      _loadingAtIndex = index;
    });
    final BlueDevice blueDevice = _blueDevices[index];
    _bluePrintPos.connect(blueDevice).then((ConnectionStatus status) {
      if (status == ConnectionStatus.connected) {
        setState(() => _selectedDevice = blueDevice);
      } else if (status == ConnectionStatus.timeout) {
        _onDisconnectDevice();
      } else {
        print('$runtimeType - something wrong');
      }
      setState(() => _isLoading = false);
    });
  }

  Uint8List _parseByteList(String input) {
    final parts = input.split(',');
    final parsedBytes = parts.map((e) => int.tryParse(e)).toList();
    if (parsedBytes.contains(null)) {
      throw FormatException("Could not parse $input as list of bytes");
    }

    return Uint8List.fromList(parsedBytes.cast<int>());
  }

  Future<void> _onPrintReceipt() async {
    /// Example for Print Image
    final ByteData logoBytes = await rootBundle.load(
      'assets/images/test.jpg',
    );
    final ReceiptSectionText receiptText = ReceiptSectionText();
    // receiptText.addImage(
    //   base64.encode(Uint8List.view(logoBytes.buffer)),
    //   width: 150,
    // );

    receiptText.addText(
      'dfgdfgdfg',
      alignment: ReceiptAlignment.center,
      size: ReceiptTextSizeType.medium,
      style: ReceiptTextStyleType.bold,
    );
    // receiptText.addText(
    //   '^XA^FO50,60^A0,40^FDWorlds Best Griddle^FS^XZ',
    //   alignment: ReceiptAlignment.center,
    //   size: ReceiptTextSizeType.medium,
    //   style: ReceiptTextStyleType.bold,
    // );
    //    receiptText.addText(
    //   '^XA^FX Top s  ection with company logo, name and address.^CFF,50^CI28^PA0,1,1,1^FO55,55^GC100^FS^FO75,55^GC100^FS^FO75,75^GC100^FS^FO55,75^GC100^FS^FO88,8^GC50,50^FS^FO220,50^FDLorem Ipsum, กดเกดเInc.^FS^CF0,40^FO220,100^FD1000 Sกหดหกดhipping Lane^FS^FO220,135^FDShelbyville TN 38102^FS^FO220,170^FDEURO UNION (EU)^FS^FO50,250^GB700,1,3^FS^FX Second section with recipient address and permit information.^CFA,30^FO50,300^FDKarl Marks^FS^FO50,340^FD100 Main Street^FS^FO50,380^FDEURO UNION (EU)^FS^CFA,15^FO50,450^GB700,1,3^FS^XZ',
    //   size: ReceiptTextSizeType.medium,
    //   style: ReceiptTextStyleType.bold,
    // );
    // receiptText.addText(
    //   'Black White Street, Jakarta, Indonesia',
    //   size: ReceiptTextSizeType.small,
    // );
    // receiptText.addSpacer(useDashed: true);
    // receiptText.addLeftRightText('Time', '04/06/21, 10:00');
    // receiptText.addSpacer(useDashed: true);
    // receiptText.addLeftRightText(
    //   'Apple 1kg',
    //   'Rp30.000',
    //   leftStyle: ReceiptTextStyleType.normal,
    //   rightStyle: ReceiptTextStyleType.bold,
    // );
    // receiptText.addSpacer(useDashed: true);
    // receiptText.addLeftRightText(
    //   'TOTAL',
    //   'Rp30.000',
    //   leftStyle: ReceiptTextStyleType.normal,
    //   rightStyle: ReceiptTextStyleType.bold,
    // );
    // receiptText.addSpacer(useDashed: true);
    // receiptText.addLeftRightText(
    //   'Payment',
    //   'Cash',
    //   leftStyle: ReceiptTextStyleType.normal,
    //   rightStyle: ReceiptTextStyleType.normal,
    // );
    receiptText.addSpacer(count: 2);
    await _bluePrintPos.printReceiptText(receiptText);

    String l = 'test Thaai input';

    /// Text after QR
    // final ReceiptSectionText receiptSecondText = ReceiptSectionText();
    // receiptSecondText.addText('Powered by ayeee',
    //     size: ReceiptTextSizeType.small);
    // receiptSecondText.addSpacer();
    // await _bluePrintPos.printReceiptText(receiptSecondText, feedCount: 1);
  }
}
