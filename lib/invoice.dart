import 'dart:convert';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/model.dart';
import 'package:waterworks/printer%20libs/6.esc_pos.dart';
import 'package:waterworks/ETC/water_unit_irregular.dart';
import 'package:waterworks/write_water_unit_info.dart';
import '4_blue_thermal_printer/blue_main.dart';
import 'API/get_invoice.dart';
import 'ETC/color_green.dart';
import 'First_Page_bottomBar.dart';

//!ใบแจ้งหนี้ไปหน้าปริ๊น

String theTokenOne = '';

class Invoice_Page extends StatefulWidget {
  String? invoiceID = '';
  Invoice_Page({Key? key, this.invoiceID}) : super(key: key);

  @override
  State<Invoice_Page> createState() => _Invoice_PageState();
}

class _Invoice_PageState extends State<Invoice_Page> {
  @override
  ToInvoice toInvoiceModel = ToInvoice();
  bool checkWater = false;
  void initState() {
    getToken();

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
              FutureBuilder<Invoice_Data>(
                future: fetch_invoice(
                    theTokenOne.toString(), widget.invoiceID.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Invoice_Data? data = snapshot.data;
                    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    String add = data!.customerAddress.toString();
                    var newAddress = add.substring(0, 6);
                    String dis = '0';
                    if (data.discount.toString() == 'null') {
                      dis = '0';
                    } else {
                      dis = data.discount.toString();
                    }

                    toInvoiceModel.inv_number = data.invoiceNumber.toString();
                    toInvoiceModel.inv_user_number =
                        data.waterMeterRecord!.waterNumber.toString();

                    toInvoiceModel.inv_user_name = data.customerName.toString();
                    toInvoiceModel.inv_user_address =
                        data.customerAddress.toString();
                    //?-------------------------------
                    toInvoiceModel.inv_date = data.issueDate.toString();
                    toInvoiceModel.inv_matr_number =
                        data.waterMeterRecord!.currentUnit.toString();
                    toInvoiceModel.inv_unit_use =
                        data.waterMeterRecord!.sumUnit.toString();
                    toInvoiceModel.inv_prapa_cost = data.sum.toString();
                    toInvoiceModel.inv_discount = dis.toString();
                    toInvoiceModel.inv_service = data.sumService.toString();
                    toInvoiceModel.inv_vat = data.vat.toString();
                    toInvoiceModel.inv_total = data.total.toString();

                    toInvoiceModel.inv_notPay = data.countInvoices.toString();
                    toInvoiceModel.godTotal = data.sumTotal.toString();

                    toInvoiceModel.inv_dueDate = data.dueDate.toString();

                    toInvoiceModel.inv_barcode =
                        data.crossbankNumber.toString();
                    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    String irregular_Water =
                        data.waterMeterRecord!.waterWrong.toString();
                    if (irregular_Water == "2") {
                      //print('2');
                      checkWater = true;
                    } else {
                      checkWater = false;
                      // print('1');
                    }

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
                                child: Text(data.customerName.toString(),
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
                                    Text(newAddress,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('เลขที่ใบแจ้งค่าน้ำ',
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
                                    Text(
                                        data.waterMeterRecord!.waterNumber
                                            .toString(),
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
                                      data.issueDate.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                           
                              ],
                            ),
                          
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Color.fromARGB(255, 177, 177, 177),
                              thickness: 0.5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('วันที่อ่านค่า',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(data.issueDate.toString()),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('เลขในมาตราน้ำ',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(data
                                              .waterMeterRecord!.currentUnit
                                              .toString()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'หน่วย',
                                            style: TextStyle(
                                                color: Colors.transparent),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('หน่วยน้ำที่ใช้',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(data.waterMeterRecord!.sumUnit
                                              .toString()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('หน่วย',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ค่าน้ำประปา',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(data.sum.toString()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('บาท',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ส่วนลด',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(data.discount.toString()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('บาท',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ค่าบริการ',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(data.sumService.toString()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('บาท',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ภาษีมูลค่าเพิ่ม 7% ',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(data.vat.toString()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('บาท',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ค้างชำระ',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text('0'),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('เดือน',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('รวมเป็น',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(data.total.toString()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('บาท',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('รวมเงินที่ต้องชำระทั้งสิ้น',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 51, 51),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(data.sumTotal.toString(),
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 51, 51, 51),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('บาท',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 51, 51, 51),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  BarcodeWidget(
                                      barcode:
                                          Barcode.code128(useCode128A: true),
                                      data: data.crossbankNumber.toString(),
                                      width: 500,
                                      height: 50),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Palette.thisGreen,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )),
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();

                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          duration: Duration(milliseconds: 250),
                                          type: PageTransitionType.rightToLeft,
                                          child: MyApp(
                                            invoideModel: toInvoiceModel,
                                            checkWaterWrong: '1',
                                          ),
                                        ),
                                      );
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
                                  checkWater
                                      ? ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  255, 247, 113, 60),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              )),
                                          onPressed: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();

                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    duration: Duration(
                                                        milliseconds: 250),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    child: MyApp(
                                                      invoideModel:
                                                          toInvoiceModel,
                                                      checkWaterWrong: '2',
                                                    )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "สั่งพิมพ์หน่วยน้ำผิดปกติ",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Text('')
                                ],
                              ),
                            )
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

              // SizedBox(
              //   height: 20,
              // ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       primary: Palette.thisGreen,
              //       elevation: 0,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15),
              //       )),
              //   onPressed: () {
              //     FocusManager.instance.primaryFocus?.unfocus();
              //     // SweetAlertV2.show(context,
              //     //     title: "Just show a message",
              //     //     subtitle: "Sweet alert is pretty",
              //     //     style: SweetAlertV2Style.success);

              //     Navigator.push(
              //       context,
              //       PageTransition(
              //         duration: Duration(milliseconds: 250),
              //         type: PageTransitionType.rightToLeft,
              //         child: MyApp_Printer(invoideModel:  toInvoiceModel,),
              //       ),
              //     );
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Container(
              //       alignment: Alignment.center,
              //       child: Text(
              //         "สั่งพิมพ์",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       primary: Color.fromARGB(255, 255, 235, 192),
              //       elevation: 0,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15),
              //       )),
              //   onPressed: () {
              //     FocusManager.instance.primaryFocus?.unfocus();
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Container(
              //       alignment: Alignment.center,
              //       child: Text(
              //         "สั่งพิมพ์ใบแจ้งหน่วยน้ำผิดปกติ",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Color.fromARGB(255, 98, 41, 0)),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future getToken() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    var getThatToken = prefs2.get('keyToken');
    print('---------------' + getThatToken.toString());
    setState(() {
      theTokenOne = getThatToken.toString();
    });
  }
}
