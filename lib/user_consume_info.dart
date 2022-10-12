import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waterworks/water_unit_info.dart';

import 'ETC/color_green.dart';

class Use_Water_Info extends StatefulWidget {
  Use_Water_Info({Key? key}) : super(key: key);

  @override
  State<Use_Water_Info> createState() => _Use_Water_InfoState();
}

class _Use_Water_InfoState extends State<Use_Water_Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Palette.thisGreen,
                )),
            Text(
              'ข้อมูลผู้ใช้น้ำ',
              style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
            ),
            Text(''),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 SvgPicture.asset('assets/images/alert.svg', color: Color.fromARGB(255, 255, 0, 0)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ผู้ใช้น้ำค้างชำระค่าน้ำประปา 1 เดือน',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 188, 0, 0)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 245, 245, 245),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'คุณชวันธร วีรจรรยาพันธ์',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'บ้านเลขที่ 123/544',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 83, 83, 83)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'มาตราวัดน้ำ:',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 83, 83, 83)),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Color.fromARGB(255, 221, 221, 221)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                '000000',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'เลข ป:',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 83, 83, 83)),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Color.fromARGB(255, 221, 221, 221)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                '00',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'เขต:',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 83, 83, 83)),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Color.fromARGB(255, 221, 221, 221)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                '00',
                                style: TextStyle(
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
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(width: 5.0, color: Palette.thisGreen),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'ประวัติการใช้น้ำ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 101, 101, 101),
                              fontSize: 20),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Palette.thisGreen,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'เดือน',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('หน่วย',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text('จำนวนเงิน',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          '04/2565',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 233, 14, 14)),
                        ),
                      ),
                      Text('283',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 233, 14, 14))),
                      Text('453.13',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 233, 14, 14))),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          '03/2565',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen),
                        ),
                      ),
                      Text('211',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen)),
                      Text('554.13',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen)),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          '04/2565',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen),
                        ),
                      ),
                      Text('283',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen)),
                      Text('453.13',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen)),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          '04/2565',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen),
                        ),
                      ),
                      Text('283',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen)),
                      Text('453.13',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen)),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          '04/2565',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen),
                        ),
                      ),
                      Text('283',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen)),
                      Text('453.13',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.thisGreen)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
