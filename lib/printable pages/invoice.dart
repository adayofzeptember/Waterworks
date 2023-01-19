import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/printable%20pages/printer_select_commit.dart';
import 'package:waterworks/printable%20pages/water_unit_irregular.dart';
import 'package:waterworks/write_water_unit_info.dart';
import '../API/get_invoice.dart';
import '../ETC/color_green.dart';
import '../First_Page_bottomBar.dart';

//!ใบแจ้งหนี้

String theTokenOne = '';

class Invoice_Page extends StatefulWidget {
  String? invoiceID = '';
  Invoice_Page({Key? key, this.invoiceID}) : super(key: key);

  @override
  State<Invoice_Page> createState() => _Invoice_PageState();
}

class _Invoice_PageState extends State<Invoice_Page> {
  @override
  void initState() {
    
    getToken();
    print(widget.invoiceID.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 250),
                      type: PageTransitionType.rightToLeft,
                      child: Menu_Page(),
                    ),
                  );
                },
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.arrow_back_ios_new,
                        color: Palette.thisGreen))),
            SizedBox(
              width: 90,
            ),
            Text(
              'ใบแจ้งหนี้',
              style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       PageTransition(
              //         duration: Duration(milliseconds: 250),
              //         type: PageTransitionType.rightToLeft,
              //         child: Irregular_Water(),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Color.fromARGB(255, 255, 235, 192),
              //         borderRadius: BorderRadius.all(Radius.circular(10))),
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(Icons.warning_amber_rounded,
              //               color: Color.fromARGB(255, 216, 116, 0)),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Text(
              //             'หน่วยน้ำผิดปกติ',
              //             style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold,
              //                 color: Color.fromARGB(255, 98, 41, 0)),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Color.fromARGB(255, 255, 232, 232),
              //       borderRadius: BorderRadius.all(Radius.circular(10))),
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SvgPicture.asset('assets/images/alert.svg',
              //             color: Color.fromARGB(255, 255, 0, 0)),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           'ผู้ใช้น้ำค้างชำระค่าน้ำประปา 1 เดือน',
              //           style: TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold,
              //               color: Color.fromARGB(255, 188, 0, 0)),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Container(
              //     width: double.infinity,
              //     child: SvgPicture.asset(
              //       'assets/images/r2.svg',
              //       fit: BoxFit.cover,
              //     )),

              FutureBuilder<Invoice_Data>(
                future: fetch_invoice(
                    theTokenOne.toString(), widget.invoiceID.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Invoice_Data? data = snapshot.data;
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 241, 241, 241),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Image.asset(
                              'assets/images/badge.png',
                              height: 80,
                              width: 80,
                            )),
                            Center(
                                child: Text(
                              'ใบแจ้งหนี้ค่าน้ำประปา',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.thisGreen),
                            )),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                                child: Text(data!.customerName.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(
                                            255, 100, 100, 100)))),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('บ้านเลขที่',
                                        style: TextStyle(color: Colors.grey)),
                                    Text('777',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('ใบเสร็จที่',
                                        style: TextStyle(color: Colors.grey)),
                                    Text(data.invoiceNumber.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('เลชที่ผู้ใช้น้ำ',
                                        style: TextStyle(color: Colors.grey)),
                                    Text(data.userId.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('เขต',
                                        style: TextStyle(color: Colors.grey)),
                                    Text(data.areaNumber.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              color: Color.fromARGB(255, 177, 177, 177),
                              thickness: 0.5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'ค่าน้ำประจำเดือน: ',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 133, 133, 133),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'กันยายน 2560',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  '100.00 ฿',
                                  style: TextStyle(
                                      color: Palette.thisGreen,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'ค่าน้ำประจำเดือน: ',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 133, 133, 133),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'ตุลาคม 2560',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  '100.00 ฿',
                                  style: TextStyle(
                                      color: Palette.thisGreen,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'รวมเป็นเงิน: ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 133, 133, 133),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data.sum.toString() + ' ฿',
                                  style: TextStyle(
                                      color: Palette.thisGreen,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: CircularProgressIndicator(
                        color: Palette.thisGreen,
                      )),
                    ],
                  );
                },
              ),

              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Palette.thisGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  // SweetAlertV2.show(context,
                  //     title: "Just show a message",
                  //     subtitle: "Sweet alert is pretty",
                  //     style: SweetAlertV2Style.success);

                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //       duration: Duration(milliseconds: 500),
                  //       type: PageTransitionType.bottomToTop,
                  //       child: MyHomePage()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "สั่งพิมพ์",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 235, 192),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "สั่งพิมพ์ใบแจ้งหน่วยน้ำผิดปกติ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 98, 41, 0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getToken() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    var getThatToken = prefs2.get('keyToken');

    setState(() {
      theTokenOne = getThatToken.toString();
    });
  }
}
