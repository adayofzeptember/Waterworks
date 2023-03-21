// ignore_for_file: deprecated_member_use
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/models/invoice_to_printer.dart';
import 'package:waterworks/service/get_invoice.dart';
import '../ETC/color_green.dart';
import '../ETC/month_thai_covert.dart';
import '../bloc/load_undone/undone_bloc.dart';
import '../blue_thermal_printer/print_page.dart';
import 'First_Page_bottomBar.dart';
//!ใบแจ้งหนี้ไปหน้าปริ๊น

String theTokenOne = '';

class Invoice_Page extends StatefulWidget {
  String? invoiceID = '';
  String? ckeckWidget = '';
  Invoice_Page({Key? key, this.invoiceID, this.ckeckWidget}) : super(key: key);

  @override
  State<Invoice_Page> createState() => _Invoice_PageState();
}

class _Invoice_PageState extends State<Invoice_Page> {
  @override
  late Future<Invoice_Data> futureINV;
  MonthTH m = MonthTH();
  ToInvoice toInvoiceModel = ToInvoice();
  bool checkWater = false;
  void initState() {
    print(widget.ckeckWidget);
    // print(widget.ckeckWidget);
    futureINV = fetch_invoice(widget.invoiceID.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 250),
            type: PageTransitionType.rightToLeft,
            child: (Menu_Page()),
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              InkWell(
                  onTap: () async {
                    if (widget.ckeckWidget == 'from_list') {
                      Navigator.pop(context);
                    } else {
                      print('1');
                      context.read<NotWriteBloc>().add(BackMenu());
                      await Navigator.pushReplacement(
                        context,
                        PageTransition(
                          duration: const Duration(milliseconds: 250),
                          type: PageTransitionType.rightToLeft,
                          child: Menu_Page(),
                        ),
                      );
                    }
                  },
                  child: const SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(Icons.arrow_back_ios_new,
                          color: Palette.thisGreen))),
              const SizedBox(
                width: 90,
              ),
              const Text(
                'ใบแจ้งหนี้',
                style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
              ),
            ],
          ),
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
                  FutureBuilder<Invoice_Data>(
                    future: futureINV,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Invoice_Data? data = snapshot.data;

                        String add = data!.customerAddress.toString();
                        String newAddress = add.substring(0, 6);
                        String dis = '0';
                        if (data.discount.toString() == 'null') {
                          dis = '0';
                        } else {
                          dis = data.discount.toString();
                        }

                        String month = data.issueDate.toString();
                        String monthThai = month.substring(5, 7);

                        toInvoiceModel.inv_number = data.invoiceNumber.toString();
                        toInvoiceModel.inv_user_number = data.waterMeterRecord!.waterNumber.toString();

                        toInvoiceModel.inv_user_name =
                            data.customerName.toString();
                        toInvoiceModel.inv_user_address =
                            data.customerAddress.toString();
                        //?---------------------------------------------------------

                        toInvoiceModel.inv_record_date =
                            data.waterMeterRecord!.record_date_format;

                        toInvoiceModel.inv_matr_number =
                            data.waterMeterRecord!.currentUnit.toString();

                        toInvoiceModel.inv_matr_previous_number =
                            data.waterMeterRecord!.previousUnit.toString();

                        toInvoiceModel.inv_unit_use =
                            data.waterMeterRecord!.sumUnit.toString();
                        toInvoiceModel.inv_prapa_cost = data.sum.toString();

                        toInvoiceModel.inv_service = data.sumService.toString();

                        toInvoiceModel.inv_vat = data.vat.toString();

                        toInvoiceModel.inv_total = data.total.toString();

                        toInvoiceModel.inv_notPay =
                            data.countInvoices.toString();

                        toInvoiceModel.godTotal = data.sumTotal.toString();

                        toInvoiceModel.inv_dueDate =
                            data.due_date_format.toString();

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

                        print('น้ำปกติ: ' + irregular_Water);

                        return Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
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
                                const SizedBox(
                                  height: 5,
                                ),
                                const Center(
                                    child: Text(
                                  'ใบแจ้งหนี้ค่าน้ำประปา',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.thisGreen),
                                )),
                                const SizedBox(
                                  height: 15,
                                ),
                                Center(
                                    child: Text(data.customerName.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 100, 100, 100)))),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Text('บ้านเลขที่',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Text(newAddress,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text('เลขที่ใบแจ้งค่าน้ำ',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Text(data.invoiceNumber.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text('เลชที่ผู้ใช้น้ำ',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Text(
                                            data.waterMeterRecord!.waterNumber
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text('เขต',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Text(data.areaNumber.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Divider(
                                  color: Color.fromARGB(255, 177, 177, 177),
                                  thickness: 0.5,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'ค่าน้ำประจำเดือน: ',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          m.convertMonth(monthThai).toString(),
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        checkWater
                                            ? Text(
                                                '(น้ำผิดปกติ)',
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              )
                                            : Text(
                                                '(น้ำปกติ)',
                                                style: TextStyle(
                                                    color: Palette.thisGreen),
                                              )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  color: Color.fromARGB(255, 177, 177, 177),
                                  thickness: 0.5,
                                ),
                                const SizedBox(
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
                                          const Text('วันที่อ่านค่า',
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
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('เลขในมาตรน้ำ',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              Text(data
                                                  .waterMeterRecord!.currentUnit
                                                  .toString()),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'หน่วย',
                                                style: TextStyle(
                                                    color: Colors.transparent),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('หน่วยน้ำที่ใช้',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              Text(data
                                                  .waterMeterRecord!.sumUnit
                                                  .toString()),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text('หน่วย',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 133, 133, 133),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('ค่าน้ำประปา',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              Text(data.sum.toString()),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text('บาท',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 133, 133, 133),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          )
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text('ส่วนลด',
                                      //         style: TextStyle(
                                      //             color: Color.fromARGB(
                                      //                 255, 133, 133, 133),
                                      //             fontWeight: FontWeight.bold)),
                                      //     Row(
                                      //       children: [
                                      //         Text(data.discount.toString()),
                                      //         SizedBox(
                                      //           width: 10,
                                      //         ),
                                      //         Text('บาท',
                                      //             style: TextStyle(
                                      //                 color: Color.fromARGB(
                                      //                     255, 133, 133, 133),
                                      //                 fontWeight: FontWeight.bold))
                                      //       ],
                                      //     )
                                      //   ],
                                      // ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('ค่าบริการ',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              Text(data.sumService.toString()),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text('บาท',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 133, 133, 133),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('ภาษีมูลค่าเพิ่ม 7% ',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              Text(data.vat.toString()),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text('บาท',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 133, 133, 133),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text('ค้างชำระ',
                                      //         style: TextStyle(
                                      //             color: Color.fromARGB(
                                      //                 255, 133, 133, 133),
                                      //             fontWeight: FontWeight.bold)),
                                      //     Row(
                                      //       children: [
                                      //         Text('0'),
                                      //         SizedBox(
                                      //           width: 10,
                                      //         ),
                                      //         Text('เดือน',
                                      //             style: TextStyle(
                                      //                 color: Color.fromARGB(
                                      //                     255, 133, 133, 133),
                                      //                 fontWeight: FontWeight.bold))
                                      //       ],
                                      //     )
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('รวมเป็น',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              Text(data.total.toString()),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text('บาท',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 133, 133, 133),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                              'รวมเงินที่ต้องชำระทั้งสิ้น',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 51, 51, 51),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              Text(data.sumTotal.toString(),
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 51, 51, 51),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text('บาท',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 51, 51, 51),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      BarcodeWidget(
                                          barcode: Barcode.code128(
                                              useCode128A: true),
                                          data: data.crossbankNumber.toString(),
                                          width: 500,
                                          height: 50),
                                      const SizedBox(
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
                                              duration: const Duration(
                                                  milliseconds: 250),
                                              type: PageTransitionType
                                                  .rightToLeft,
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
                                            child: const Text(
                                              "สั่งพิมพ์",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      checkWater
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: const Color.fromARGB(
                                                      255, 247, 113, 60),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  )),
                                              onPressed: () {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();

                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    250),
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        child: MyApp(
                                                          invoideModel:
                                                              toInvoiceModel,
                                                          checkWaterWrong: '2',
                                                        )));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                    "สั่งพิมพ์หน่วยน้ำผิดปกติ",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const Text('')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                snapshot.error.toString(),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
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
        ),
      ),
    );
  }
}
