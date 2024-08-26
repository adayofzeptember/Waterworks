// ignore_for_file: deprecated_member_use

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
import '../models/invoice_bill_model_TOPRINTER.dart';

class InvoicePage2 extends StatelessWidget {
  const InvoicePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToInvoice toInvoiceModel = ToInvoice();
    ToPrint_Bill toBillModel = ToPrint_Bill();
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

                  print('-----'+state.invoice_data.paymentAutoCheck.toString());
                  print('-----'+state.invoice_data.information_textdebitbank.toString());
                  print('-----'+state.invoice_data.information_textAlert.toString());

        

                  String add = state.invoice_data.customerAddress.toString();
                  String newAddress = add.substring(0, 6);
                  String month = state.invoice_data.write_date.toString();
                  String monthThai = month.substring(3, 8);
                  // String dateNum =
                  //     state.invoice_data.write_date.toString().substring(1, 2);

                  var qrCode = state.invoice_data.bank.toString().split('\n');

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

                  toInvoiceModel.inv_current_month =
                      state.invoice_data.issue_month.toString();
//!
                  toInvoiceModel.inv_matr_previous_number = state
                      .invoice_data.water_meter_record_beforeUnit
                      .toString();

                  toInvoiceModel.inv_matr_previous_month =
                      "(${state.invoice_data.water_meter_record_beforeMonth.toString()})";

                  toInvoiceModel.inv_matr_now_month =
                      "(${state.invoice_data.water_meter_record_nowMonth.toString()})";
                  toInvoiceModel.inv_matr_now_number =
                      state.invoice_data.water_meter_record_nowUnit.toString();

//!
                  toInvoiceModel.inv_qr = qrCode;

                  toInvoiceModel.inv_barcode2 =
                      state.invoice_data.bank_barcode.toString();
                  toInvoiceModel.dueDate =
                      state.invoice_data.dueDate.toString();

                  //*
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

                  // state.invoice_data.bank.toString();
                  //*new
                  toInvoiceModel.total_format =
                      state.invoice_data.total_format.toString();
                  toInvoiceModel.meter_number =
                      state.invoice_data.meter_number.toString();
                  toInvoiceModel.sum_total =
                      state.invoice_data.sum_total.toString();
                  toInvoiceModel.month = m.convertMonth(monthThai);
                  toInvoiceModel.meter_name =
                      state.invoice_data.meter_name.toString();
                  toInvoiceModel.fiveMonths_Back_Model =
                      state.invoice_data.fiveMonths_Back_Model;
                  toInvoiceModel.sum_months =
                      state.invoice_data.sum_months.toString();
                  toInvoiceModel.debtmonths_step =
                      state.invoice_data.debt_months_step;

                  toInvoiceModel.information_discountText =
                      state.invoice_data.information_discountText.toString();
                  toInvoiceModel.information_textDuedate =
                      state.invoice_data.information_textDuedate.toString();
                  toInvoiceModel.information_textOverdue =
                      state.invoice_data.information_textOverdue.toString();
                  toInvoiceModel.information_waterWrong =
                      state.invoice_data.information_waterWrong.toString();


                      toInvoiceModel.information_textdebitbank =     state.invoice_data.information_textdebitbank.toString();
                      toInvoiceModel.information_textAlert =     state.invoice_data.information_textAlert.toString();

                  toInvoiceModel.inv_tax = state.invoice_data.tax;

                  toInvoiceModel.sum_total_text =
                      state.invoice_data.sum_total_text.toString();
                  
                  String debCheck = '';
                  bool meterWrong;
                  if (state.invoice_data.paymentAutoCheck.toString() == '0' ||state.invoice_data.paymentAutoCheck.toString() == 'null') {
                    debCheck = '0';
                  } else {
                    debCheck = '1';
                  }
                  //?
                  if (state.invoice_data.meter_status.toString() == "0") {
                    meterWrong = false;
                  } else if (state.invoice_data.meter_status.toString() ==
                          "1" ||
                      state.invoice_data.meter_status.toString() == "2") {
                    meterWrong = true;
                    toInvoiceModel.wrong_water =
                        state.invoice_data.meter_status_text.toString();
                  } else {
                    meterWrong = false;
                  }

                  // print(toInvoiceModel.inv_barcode2);

                  //!----------------------------BILL----------------------------
                  toBillModel.bill_number = state.bill_data.bill_number;
                  toBillModel.bill_customerName =
                      state.bill_data.bill_customerName;

                  toBillModel.bill_customerAddress =
                      state.bill_data.bill_customerAddress;
                  toBillModel.bill_taxNumber = state.bill_data.bill_taxNumber;

                  toBillModel.bill_areaNumber = state.bill_data.bill_areaNumber;

                  toBillModel.bill_waterNumber =
                      state.bill_data.bill_waterNumber;

                  toBillModel.bill_Month = state.bill_data.bill_Month;

                  toBillModel.bill_meterNumber =
                      state.bill_data.bill_meterNumber;

                  toBillModel.bill_size = state.bill_data.bill_size;

                  toBillModel.bill_invoiceNumber =
                      state.bill_data.bill_invoiceNumber;

                  toBillModel.bill_nowNumber = state.bill_data.bill_nowNumber;
                  toBillModel.bill_previousNumber =
                      state.bill_data.bill_previousNumber;

                  toBillModel.bill_sumUnit = state.bill_data.bill_sumUnit;

                  toBillModel.bill_sumFormat = state.bill_data.bill_sumFormat;

                  toBillModel.bill_sumService = state.bill_data.bill_sumService;

                  toBillModel.bill_discount = state.bill_data.bill_discount;

                  toBillModel.bill_vat = state.bill_data.bill_vat;

                  toBillModel.bill_totalFormat =
                      state.bill_data.bill_totalFormat;
                  toBillModel.bill_totalFormat_text =
                      state.bill_data.bill_totalFormat_text;

                  toBillModel.bill_zpl = state.bill_data.bill_zpl;
                  toBillModel.fiveMonths_Back_Model =
                      state.bill_data.fiveMonths_Back_Model;

                  //
                  toBillModel.bill_zpl = state.bill_data.bill_zpl;
                  toBillModel.bill_paymentType =
                      state.bill_data.bill_paymentType;
                  toBillModel.bill_recieveName =
                      state.bill_data.bill_recieveName;
                  toBillModel.bill_recievePosition =
                      state.bill_data.bill_recievePosition;
                  toBillModel.bill_issue_dateFormat =
                      state.bill_data.bill_issue_dateFormat;

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
                              'ใบแจ้งค่าน้ำประปา',
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
                                    meterWrong
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
                                  // InkWell(
                                  //   onTap: () {
                                  //     convertAndShowImage(context);
                                  //   },
                                  //   child: Text('sdf')),
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
                                              state.invoice_data.sum_total
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
                                  if (state.invoice_data.invoiceStatus ==
                                      "pending")
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Palette.thisGreen,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          )),
                                      onPressed: () {
                                        print(state.invoice_data.dueDate);
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            duration: const Duration(
                                                milliseconds: 250),
                                            type: PageTransitionType.fade,
                                            child: Print_Screen(
                                              billModel: toBillModel,
                                              invoideModel: toInvoiceModel,
                                              checkWaterWrong: '1',
                                              debt: debCheck,
                                              checkPaymentAuto: debCheck,
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    const Center(
                                      child: Text(
                                        'x ใบแจ้งหนี้ถูกยกเลิก',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  meterWrong
                                      ? ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
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
                                                    duration: const Duration(
                                                        milliseconds: 250),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    child: Print_Screen(
                                                      checkPaymentAuto: debCheck,
                                                      billModel: toBillModel,
                                                      invoideModel:
                                                          toInvoiceModel,
                                                      checkWaterWrong: '2',
                                                    )));
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
