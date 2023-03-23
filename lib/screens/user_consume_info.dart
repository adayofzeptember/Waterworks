import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

import '../ETC/color_green.dart';
import '../service/get_user_consume.dart';

class Use_Water_Info extends StatefulWidget {
  String? id = '';
  Use_Water_Info({Key? key, this.id}) : super(key: key);

  @override
  State<Use_Water_Info> createState() => _Use_Water_InfoState();
}

class _Use_Water_InfoState extends State<Use_Water_Info> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'ข้อมูลผู้ใช้น้ำ',
          style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const SizedBox(
                width: 50,
                height: 50,
                child:
                    Icon(Icons.arrow_back_ios_new, color: Palette.thisGreen))),

      
      ),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                FutureBuilder<User_Consume_Data>(
                  future: fetch_user_consume(widget.id.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      User_Consume_Data? data = snapshot.data;
                      return Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 245, 245, 245),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    data!.customerWater!.name.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'บ้านเลขที่ ' +
                                        data.customerWater!.address.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 83, 83, 83)),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'มาตรวัดน้ำ:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 83, 83, 83)),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Color.fromARGB(
                                                255, 221, 221, 221)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Text(
                                            data.customerWater!.meterNumber
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      const Text(
                                        'เลข ป:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 83, 83, 83)),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Color.fromARGB(
                                                255, 221, 221, 221)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Text(
                                            data.waterNumber.toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      const Text(
                                        'เขต:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 83, 83, 83)),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Color.fromARGB(
                                                255, 221, 221, 221)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Text(
                                            data.areaNumber.toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(5.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    width: 5.0, color: Palette.thisGreen),
                              ),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      'ประวัติการใช้น้ำ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 101, 101, 101),
                                          fontSize: 20),
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Palette.thisGreen,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: const [
                                  Text(
                                    'เดือน',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 120,
                                  ),
                                  const Text('หน่วย',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    width: 65,
                                  ),
                                  const Text('จำนวนเงิน',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          //! list ตรงนี้
                          // Text(data.historyWaters![1].id.toString())
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.historyWaters!.length,
                              itemBuilder: (BuildContext context, int index) {
                              
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 233, 233, 233),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          data.historyWaters![index].recordDate.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Palette.thisGreen,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 60),
                                        Text(
                                            data.historyWaters![index]
                                                .currentUnit
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Palette.thisGreen,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 90),
                                        Text(
                                            data.historyWaters![index].sumUnit
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Palette.thisGreen,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Center(
                            child: CircularProgressIndicator(
                          color: Palette.thisGreen,
                        )),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
