// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waterworks/offline/office_route.dart';
import 'package:waterworks/offline/service/water_db.dart';
import '../ETC/color_green.dart';
import 'models/waterModel.dart';

class PageOffline extends StatefulWidget {
  const PageOffline({Key? key}) : super(key: key);

  @override
  _PageOfflineState createState() => _PageOfflineState();
}

class _PageOfflineState extends State<PageOffline> {
  late WatersDatabase _db;
  late Future<List<Water>> waters;
  int i = 0;
  Future<void> createWater(numPor, zone, numMeter) async {

    i++;
    setState(() {
      waters = _db.selectAllWater();
    });
  }

  Future<void> deleteWater(int id) async {
    await _db.deleteByIdWater(id);
    setState(() {
      waters = _db.selectAllWater();
    });
  }

  @override
  void initState() {
    _db = WatersDatabase.instance;
    // TODO: implement initState
    waters = _db.selectAllWater();
    // waters.then(
    //   (value) {
    //     print(value.length);
    //   },
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บันทึก'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, searchPage());
            },
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.white),
                Text(
                  'ค้นหาผู้ใช้น้ำ',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Water>>(
        future: waters,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Water water = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 191, 191, 191),
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                          offset: Offset(2.0, 3.0),
                        )
                      ],
                    ),
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'เลข ป.: ',
                                    style: TextStyle(color: Colors.grey[800], fontSize: 16),
                                  ),
                                  Text(
                                    '${water.numPor}',
                                    style: const TextStyle(
                                      color: Palette.thisGreen,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'มาตรวัดน้ำ: ',
                                    style: TextStyle(color: Colors.grey[800], fontSize: 16),
                                  ),
                                  Text(
                                    '${water.numMeter}',
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'เขต: ',
                                    style: TextStyle(color: Colors.grey[800], fontSize: 16),
                                  ),
                                  Text(
                                    '${water.zone}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text('${water.saveDate}'),
                            ],
                          ),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  deleteWater(int.parse("${water.id}"));
                                },
                                child: const Text(
                                  'ลบ',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              // TextButton(
                              //   onPressed: () {},
                              //   child: Text('ส่งข้อมูล'),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveData();
        },
        label: Text('บันทึกข้อมูล'),
        backgroundColor: Palette.thisGreen,
      ),
    );
  }

  Future<void> saveData() async {
    var numPorController = TextEditingController();
    var zoneController = TextEditingController();
    var materController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('บันทึกข้อมูล'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                FieldsForm(
                  controller: zoneController,
                  hintText: 'เขต',
                ),
                FieldsForm(
                  controller: numPorController,
                  hintText: 'เลข ป',
                ),
                FieldsForm(
                  controller: materController,
                  hintText: 'เลขอ่านมาตร',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'ยกเลิก',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('บันทึก'),
              onPressed: () {
                if (numPorController.text != "" && zoneController.text != "" && materController.text != "") {
                  createWater(
                    numPorController.text,
                    zoneController.text,
                    materController.text,
                  );
                  numPorController.text = "";
                  zoneController.text = "";
                  materController.text = "";

                  Navigator.pop(context);
                  setState(() {});
                } else {
                  Fluttertoast.showToast(
                      msg: 'ระบุข้อมูลไม่ถูกต้อง',
                      backgroundColor: Colors.red,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class FieldsForm extends StatelessWidget {
  FieldsForm({Key? key, required this.controller, required this.hintText}) : super(key: key);
  var controller;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
