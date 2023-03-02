import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waterworks/offline/models/history_invoicesModel.dart';
import 'package:waterworks/offline/models/history_waterModel.dart';
import 'package:waterworks/offline/service/hisinvoices_db.dart';
import 'package:waterworks/offline/service/hiswater_db%20.dart';

import '../ETC/color_green.dart';

class DetailCustomer extends StatefulWidget {
  DetailCustomer({
    Key? key,
    required this.cus_name,
    required this.area_number,
    required this.water_number,
    required this.address,
    required this.matWater,
  }) : super(key: key);
  String cus_name = "", water_number = "", area_number = "", address = "", matWater = "";

  @override
  _DetailCustomerState createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  int menu = 1;

  @override
  void initState() {
    // TODO: implement initState
    _db = HisInvoicesDatabase.instance;
    _dbWater = HisWaterDatabase.instance;
    hisInvoices = _db.selectAllHisInvoices();
    hisWater = _dbWater.selectAllHisWater();
    loadDetail();
    super.initState();
  }

  late Future<List<HisInvoices>> hisInvoices;
  late Future<List<HisWater>> hisWater;
  late HisInvoicesDatabase _db;
  late HisWaterDatabase _dbWater;
  var invoices = [], waterData = [];
  void loadDetail() {
    hisInvoices.then(
      (value) {
        for (var el in value) {
          // print(el.area_number);
          // print(el.data_id);
          if (el.water_number == widget.water_number && el.area_number == widget.area_number) {
            invoices.add({
              "date": el.issue_date_format,
              "total": el.total,
            });
            setState(() {});
          }
        }
      },
    );
    hisWater.then(
      (value) async {
        print(value.length);
        for (var el in value) {
          print(el.data_id);
          if (el.water_number == widget.water_number && el.area_number == widget.area_number) {
            List datetime = el.record_date!.split(' ');
            waterData.add({'month': datetime[0], 'unit': el.current_unit});
            setState(() {});
          }
        }
      },
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลผู้ใช้น้ำ"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.cus_name,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ที่อยู่: ' + widget.address,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'มาตรวัดน้ำ: ' + widget.matWater,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'เลข ป: ' + widget.water_number,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'เขต: ' + widget.area_number,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MenuHistory(
                title: 'ประวัติการใช้น้ำ',
                color: (menu == 1) ? Palette.thisGreen : Colors.black,
                pressed: () {
                  setState(() {
                    menu = 1;
                  });
                },
              ),
              MenuHistory(
                title: 'ประวัติการค้างชำระ',
                color: (menu == 2) ? Palette.thisGreen : Colors.black,
                pressed: () {
                  setState(() {
                    menu = 2;
                  });
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              // height: MediaQuery.of(context).size.width * .5,
              child: (menu == 1)
                  ? TableData(
                      mockup: waterData,
                    )
                  : TableDataInvoices(
                      mockup: invoices,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableData extends StatelessWidget {
  TableData({Key? key, required this.mockup}) : super(key: key);
  List<dynamic> mockup = [];
  List<DataRow> _createRows() {
    return mockup
        .map(
          (el) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
              if (mockup.indexOf(el).isEven) {
                return const Color.fromARGB(255, 242, 242, 242);
              } else {
                return Colors.white;
              }
            }),
            cells: [
              DataCell(Text('${el['month']} ')),
              DataCell(Text(el['unit'])),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Palette.thisGreen,
        ),
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'เดือน',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataColumn(
            label: Text(
              'หน่วย',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        rows: _createRows(),
      ),
    );
  }
}

class TableDataInvoices extends StatelessWidget {
  TableDataInvoices({Key? key, required this.mockup}) : super(key: key);
  List<dynamic> mockup = [];
  List<DataRow> _createRows() {
    return mockup
        .map(
          (el) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
              if (mockup.indexOf(el).isEven) {
                return const Color.fromARGB(255, 242, 242, 242);
              } else {
                return Colors.white;
              }
            }),
            cells: [
              DataCell(Text('${el['date']} ')),
              DataCell(Text('${el['total']}')),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Palette.thisGreen,
        ),
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'วันที่',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataColumn(
            label: Text(
              'เงิน',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        rows: _createRows(),
      ),
    );
  }
}

class MenuHistory extends StatelessWidget {
  MenuHistory({
    Key? key,
    required this.title,
    required this.color,
    required this.pressed,
  }) : super(key: key);
  String title;
  Color color;
  // ignore: prefer_typing_uninitialized_variables
  var pressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: pressed,
      style: OutlinedButton.styleFrom(
          side: BorderSide(
        width: 1,
        color: color,
        style: BorderStyle.solid,
      )),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
