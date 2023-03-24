import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ETC/color_green.dart';
import '../../ETC/month_thai_covert.dart';
import '../../bloc/invoice/invoice_bloc.dart';

class InvoicePage2 extends StatelessWidget {
const InvoicePage2({ Key? key }) : super(key: key);

  @override
 Widget build(BuildContext context) {
    MonthTH m = MonthTH();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
               BlocBuilder<InvoiceBloc, InvoiceState>(
                    builder: (context, state) {
                  return InkWell(
                      onTap: () async {
                        print(state.whatPage);
                      },
                      child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.arrow_back_ios_new,
                              color: Palette.thisGreen)));
                }
              ),
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
        body: 
        MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: SingleChildScrollView(child:
                BlocBuilder<InvoiceBloc, InvoiceState>(
                    builder: (context, state) {
              if (state.loading == true) {
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  ],
                );
              } else {
                String add = state.invoice_data.customerAddress.toString();
                String newAddress = add.substring(0, 6);
                String month = state.invoice_data.write_date.toString();
                String monthThai = month.substring(4, 7);

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
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
                              child: Text(state.invoice_data.customerName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 100, 100, 100)))),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Text('บ้านเลขที่',
                                      style: TextStyle(color: Colors.grey)),
                                  Text(newAddress,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('เลขที่ใบแจ้งค่าน้ำ',
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                      state.invoice_data.invoiceNumber
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('เลขที่ผู้ใช้น้ำ',
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                      state.invoice_data
                                          .waterMeterRecord_waterNumber
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('เขต',
                                      style: TextStyle(color: Colors.grey)),
                                  Text(state.invoice_data.areaNumber.toString(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'ค่าน้ำประจำเดือน: ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 133, 133, 133),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    m.convertMonth(monthThai).toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  state.invoice_data.waterMeterRecord_waterWrong
                                      ? const Text(
                                          '(น้ำผิดปกติ)',
                                          style: TextStyle(color: Colors.amber),
                                        )
                                      : const Text(
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
                                    const Text('วันที่อ่านมาตร',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 133, 133, 133),
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(state.invoice_data.write_date
                                            .toString()),
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
                                    const Text('เลขมาตรครั้งก่อน',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 133, 133, 133),
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(state.invoice_data
                                            .waterMeterRecord_previous_unit
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
                                    const Text('เลขมาตรครั้งนี้',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 133, 133, 133),
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(state.invoice_data
                                            .waterMeterRecord_current_unit
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
                                        Text(state.invoice_data
                                            .waterMeterRecord_sum_unit
                                            .toString()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('หน่วย',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 133, 133, 133),
                                                fontWeight: FontWeight.bold))
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
                                        Text(state.invoice_data.prapa_cost
                                            .toString()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('บาท',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 133, 133, 133),
                                                fontWeight: FontWeight.bold))
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
                                    const Text('ค่าบริการ',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 133, 133, 133),
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(state.invoice_data.sumService),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('บาท',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 133, 133, 133),
                                                fontWeight: FontWeight.bold))
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
                                        Text(state.invoice_data.vat.toString()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('บาท',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 133, 133, 133),
                                                fontWeight: FontWeight.bold))
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
                                    const Text('รวมเป็นเงิน',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 133, 133, 133),
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(state.invoice_data.total
                                            .toString()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('บาท',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 133, 133, 133),
                                                fontWeight: FontWeight.bold))
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
                                    Text('ค้างชำระ',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 133, 133, 133),
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(state.invoice_data.debt_months
                                            .toString()),
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
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('จำนวนเงินที่ค้างชำระ',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 133, 133, 133),
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(state.invoice_data.sum_debt
                                            .toString()),
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
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('รวมเงินที่ต้องชำระทั้งสิ้น',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 51, 51, 51),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(
                                            state.invoice_data.godTotal
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 51, 51, 51),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('บาท',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 51, 51, 51),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                BarcodeWidget(
                                    barcode: Barcode.code128(useCode128A: true),
                                    data: state.invoice_data.bank.toString(),
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
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    // Navigator.push(
                                    //   context,
                                    //   PageTransition(
                                    //     duration:
                                    //         const Duration(milliseconds: 250),
                                    //     type: PageTransitionType.rightToLeft,
                                    //     child: MyApp(
                                    //       invoideModel: toInvoiceModel,
                                    //       checkWaterWrong: '1',
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "สั่งพิมพ์",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                state.invoice_data.waterMeterRecord_waterWrong
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: const Color.fromARGB(
                                                255, 247, 113, 60),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            )),
                                        onPressed: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();

                                          // Navigator.push(
                                          //     context,
                                          //     PageTransition(
                                          //         duration: const Duration(
                                          //             milliseconds: 250),
                                          //         type: PageTransitionType
                                          //             .rightToLeft,
                                          //         child: MyApp(
                                          //           invoideModel: toInvoiceModel,
                                          //           checkWaterWrong: '2',
                                          //         )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
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
                  ),
                );
              }
            })))
            
            );
  }
}