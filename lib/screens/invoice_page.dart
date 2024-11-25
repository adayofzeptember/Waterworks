import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/ETC/month_thai_covert.dart';
import 'package:waterworks/blue_thermal_printer/printer_with_bloc.dart';
import '../ETC/color_green.dart';
import '../bloc/load_undone/undone_bloc.dart';
import '../bloc/search/search_bloc.dart';
import '../bloc/write_page/write_page_bloc.dart';
import '../ETC/models/invoice_to_printer.dart';

class InvoicePage2 extends StatelessWidget {
  const InvoicePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToInvoice toInvoiceModel = ToInvoice();
    MonthTH m = MonthTH();

    return WillPopScope(
      onWillPop: () async {
        context.read<WritePageBloc>().add(CountForReset(context: context));
        context.read<NotWriteBloc>().add(BackMenu());
        context.read<NotWriteBloc>().add(Reload_Undone());
        // context.read<DoneBloc>().add(Reload_Done());
        context.read<SearchBloc>().add(ClearSearch());

        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'ใบแจ้งหนี้',
              style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
            ),
            leading: BlocBuilder<WritePageBloc, WritePageState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () async {
                    context
                        .read<WritePageBloc>()
                        .add(CountForReset(context: context));

                    context.read<NotWriteBloc>().add(BackMenu());
                    context.read<NotWriteBloc>().add(Reload_Undone());
                    // context.read<DoneBloc>().add(Reload_Done());

                    context.read<SearchBloc>().add(ClearSearch());
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Palette.thisGreen,
                  ),
                );
              },
            ),
          ),
          body: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: SingleChildScrollView(child:
                  BlocBuilder<WritePageBloc, WritePageState>(
                      builder: (context, state) {
                if (state.loading == true) {
                  return Column(
                    children: const [
                      SizedBox(height: 20),
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
                  String monthThai = month.substring(3, 8);
                  String dateNum =
                      state.invoice_data.write_date.toString().substring(1, 2);
                  print(dateNum);
                  var qrCode;
                  if (int.parse(dateNum) >= 3) {
                    qrCode = state.invoice_data.bank.toString().split('\n');
                  } else {
                    qrCode = state.invoice_data.bank.toString().split(' ');
                  }

                  //-
                  toInvoiceModel.inv_number =
                      state.invoice_data.invoiceNumber.toString();
                  toInvoiceModel.inv_user_number = state
                      .invoice_data.waterMeterRecord_waterNumber
                      .toString();

                  toInvoiceModel.inv_user_area =
                      state.invoice_data.areaNumber.toString();

                  toInvoiceModel.inv_user_name =
                      state.invoice_data.customerName.toString();
                  toInvoiceModel.inv_user_address =
                      state.invoice_data.customerAddress.toString();

                  toInvoiceModel.inv_current_montht =
                      state.invoice_data.issue_month.toString();
                  toInvoiceModel.inv_matr_previous_number_andMonth = state
                          .invoice_data.water_meter_record_beforeUnit
                          .toString() +
                      " / " +
                      state.invoice_data.water_meter_record_beforeMonth
                          .toString();
                  toInvoiceModel.inv_matr_now_number_andMonth = state
                          .invoice_data.water_meter_record_nowUnit
                          .toString() +
                      " / " +
                      state.invoice_data.water_meter_record_nowMonth.toString();

                  toInvoiceModel.inv_unit_use =
                      state.invoice_data.waterMeterRecord_sum_unit.toString();
                  toInvoiceModel.inv_prapa_cost =
                      state.invoice_data.prapa_cost.toString();
                  toInvoiceModel.inv_service =
                      state.invoice_data.sumService.toString();
                  toInvoiceModel.inv_vat = state.invoice_data.vat.toString();
                  toInvoiceModel.inv_total =
                      state.invoice_data.total.toString();
                  toInvoiceModel.inv_sum_months =
                      state.invoice_data.sum_months.toString();
                  toInvoiceModel.inv_sum_invoice =
                      state.invoice_data.sum_invoice.toString();
                  toInvoiceModel.godTotal =
                      state.invoice_data.godTotal.toString();
                  toInvoiceModel.inv_barcode = qrCode;
                  // state.invoice_data.bank.toString();

                  String debCheck = '';
                  if (state.invoice_data.debt_months.toString() == '0') {
                    debCheck = '0';
                  } else {
                    debCheck = '1';
                  }

                  //-

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
                              height: 10,
                            ),
                            const Center(
                                child: Text(
                              'ใบแจ้งหนี้ค่าน้ำประปา',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.thisGreen),
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(state.invoice_data.customerName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(
                                            255, 100, 100, 100)))),
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
                                    Text(
                                        state.invoice_data.areaNumber
                                            .toString(),
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
                                          color: Color.fromARGB(
                                              255, 133, 133, 133),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      m.convertMonth(monthThai),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    state.invoice_data
                                            .waterMeterRecord_waterWrong
                                        ? const Text(
                                            '(น้ำผิดปกติ)',
                                            style:
                                                TextStyle(color: Colors.amber),
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
                                      const Text('เลขจดครั้งก่อน',
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
                                      const Text('เลขจดครั้งนี้',
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
                                          Text(state.invoice_data.sumService
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
                                      const Text('ภาษีมูลค่าเพิ่ม 7% ',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(state.invoice_data.vat
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
                                      const Text('ค้างชำระ',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(state.invoice_data.debt_months
                                              .toString()),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text('เดือน',
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
                                      const Text('จำนวนเงินที่ค้างชำระ',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(state.invoice_data.sum_debt
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
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('รวมเงินที่ต้องชำระทั้งสิ้น',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 51, 51),
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
                                      barcode:
                                          Barcode.code128(useCode128A: true),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )),
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();

                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          duration:
                                              const Duration(milliseconds: 250),
                                          type: PageTransitionType.fade,
                                          child: Print2(
                                            invoideModel: toInvoiceModel,
                                            checkWaterWrong: '1',
                                            debt: debCheck,
                                            bank: state.invoice_data.bank
                                                .toString(),
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
                                            //         child: Print2(
                                            //           invoideModel:
                                            //               toInvoiceModel,
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
              })))),
    );
  }
}
