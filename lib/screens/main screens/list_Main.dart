// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/bloc/load_undone/undone_bloc.dart';
import 'package:waterworks/screens/main%20screens/list_unit_done.dart';
import 'package:waterworks/screens/main%20screens/list_unit_notdone.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:http/http.dart' as http;
import '../../offline/models/customer_waterModel.dart';
import '../../offline/models/history_invoicesModel.dart';
import '../../offline/models/history_waterModel.dart';
import '../../offline/service/customers_db.dart';
import '../../offline/service/hisinvoices_db.dart';
import '../../offline/service/hiswater_db .dart';

class Water_Unit_List extends StatefulWidget {
  Water_Unit_List({Key? key}) : super(key: key);

  @override
  State<Water_Unit_List> createState() => _Water_Unit_ListState();
}

class _Water_Unit_ListState extends State<Water_Unit_List> {
  late CustomersDatabase _db;
  late HisInvoicesDatabase _dbInvoices;
  late HisWaterDatabase _dbWater;
  late Future<List<Customers>> customers;
  late Future<List<HisInvoices>> hisInvoices;
  late Future<List<HisWater>> hisWater;

  double downloadPer = 0.0;
  Future<void> downloadUsers() async {
    _db = CustomersDatabase.instance;
    _dbInvoices = HisInvoicesDatabase.instance;
    _dbWater = HisWaterDatabase.instance;
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    var getThatToken = prefs2.get('keyToken');
    final response = await http.get(
      Uri.parse(waterWork_domain + 'water_meter_record/index/all'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $getThatToken',
      },
    );
    if (response.statusCode == 200) {
      _db.deleteAllCustomers(); // ทำคำสั่งลบข้อมูลทั้งหมด
      _dbInvoices.deleteAllHisInvoices();
      _dbWater.deleteAllHisWater();
      Map<String, dynamic> resDecode = jsonDecode(response.body);
      int countData = resDecode['data'].length;
      int i = 0;
      for (var el in resDecode['data']) {
        Customers customers = Customers(
          id: null,
          data_id: el['id'].toString(),
          customer_id: (el['customer_water']['customer_id'] != null) ? el['customer_water']['customer_id'] : "",
          water_number: (el['water_number'] != null) ? el['water_number'] : "",
          area_number: (el['area_number'] != null) ? el['area_number'] : "",
          meter_number: (el['customer_water']['meter_number'] != null) ? el['customer_water']['meter_number'] : "",
          address: (el['customer_water']['address'] != null) ? el['customer_water']['address'] : "",
          type_id: (el['customer_water']['type_id'] != null) ? el['customer_water']['type_id'] : "",
          name: (el['customer_water']['name'] != null) ? el['customer_water']['name'] : "",
          status_debtor: (el['customer_water']['status_debtor'] != null) ? el['customer_water']['status_debtor'] : "",
          status_discount: (el['customer_water']['status_discount'] != null) ? el['customer_water']['status_discount'] : "",
          road: (el['customer_water']['road'] != null) ? el['customer_water']['road'] : "",
        );
        print('1');
        Customers newWater = await _db.createCustomer(customers);
        // print('customer success');
        for (var invoice in el['history_invoices']) {
          HisInvoices hisInvoices = HisInvoices(
              data_id: invoice['id'].toString(),
              customer_water_id: (invoice['customer_water_id'] != null) ? invoice['customer_water_id'] : "",
              customer_name: invoice['customer_name'],
              water_number: invoice['water_number'],
              area_number: invoice['area_number'],
              sum: invoice['sum'],
              status: invoice['status'],
              issue_date_format: invoice['issue_date_format'],
              vat: invoice['vat'],
              total: invoice['total'],
              sum_service: invoice['sum_service'],
              bill_no: (invoice['bill_no'] != null) ? invoice['bill_no'] : "");
          HisInvoices newInvoices = await _dbInvoices.createHisInvoices(hisInvoices);
          // print('his invoices success');
        }
        for (var water in el['history_waters']) {
          HisWater hisWater = HisWater(
            data_id: water['id'].toString(),
            water_number: water['water_number'],
            area_number: water['area_number'],
            status: water['status'],
            record_date: water['record_date'],
            current_unit: water['current_unit'],
          );
          HisWater newWater = await _dbWater.createHisWater(hisWater);
          // print('his water success');
        }
        i++;
        downloadPer = (i / countData) * 100;
        setState(() {});
      }
      Fluttertoast.showToast(
          msg: 'ดาวน์โหลดสำเร็จ',
          backgroundColor: Palette.thisGreen,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      throw Exception("error...");
    }
  }
    Future<void> checkBluetooth() async {
    BluetoothEnable.enableBluetooth.
    then((result) {
      if (result == "true") {
        
      } else if (result == "false") {}
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: Palette.thisGreen,
            labelColor: Palette.thisGreen,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: ("ยังไม่จด"),
              ),
              Tab(
                text: ("จดแล้ว"),
              ),
            ],
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: BlocBuilder<NotWriteBloc, NotWriteState>(
            builder: (context, state) {
              return PopupMenuButton(
                icon: const Icon(
                  Icons.filter_alt_sharp,
                  color: Palette.thisGreen,
                ),
                // surfaceTintColor: Colors.black,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: (state.hiddenMeter == '0') ? 1 : 0,
                      child: Row(
                        children: [
                          Checkbox(
                            value: (state.hiddenMeter == '1') ? true : false,
                            onChanged: null,
                          ),
                          const Text("ปิดการแสดงผลตัดมาตร"),
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (value) async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('hiddenMater', value.toString());
                  context.read<NotWriteBloc>().add(FilterData(
                        id: '-1',
                        segmentActive: 0,
                        // stopLoad: true,
                      ));
                },
              );
            },
          ),
          title: const Text(
            'รายการจดหน่วยน้ำ',
            style: TextStyle(color: Color.fromARGB(255, 83, 83, 83), fontWeight: FontWeight.bold),
          ),
          // actions: [
          //   (downloadPer != 0.0 && downloadPer != 100.0)
          //       ? Center(
          //           child: Padding(
          //             padding: const EdgeInsets.only(right: 8.0),
          //             child: Text(
          //               downloadPer.toStringAsFixed(1) + "%",
          //               style: const TextStyle(
          //                 color: Colors.grey,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         )
          //       : IconButton(
          //           onPressed: () {
          //             downloadUsers();
          //             // downloadAll();
          //           },
          //           icon: const Icon(
          //             Icons.download_for_offline_rounded,
          //             color: Palette.thisGreen,
          //           ),
          //         ),
          // ],
        ),
        body: TabBarView(
          children: [Notyet(), Done()],
        ),
      ),
    );
  }
}
