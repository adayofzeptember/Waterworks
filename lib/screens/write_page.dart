import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/shapes_painter.dart';
import 'package:waterworks/bloc/load_done/done_bloc.dart';
import 'package:waterworks/service/post_writeUnit.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/offline/utils.dart';
import '../ETC/month_thai_covert.dart';
import '../ETC/progressHUD.dart';
import '../bloc/checkbox_newround/checkbox_bloc.dart';
import '../bloc/load_undone/undone_bloc.dart';
import '../bloc/radio_butts/radio_check_bloc.dart';
import '../service/get_user_consume.dart';
import 'invoice_page.dart';

  var formatter = NumberFormat('#,##,000');

//! หน้าจด
class Water_Unit_Detail extends StatefulWidget {
  String? id = '';
  String? porNumber = '';

  Water_Unit_Detail({Key? key, this.id, this.porNumber}) : super(key: key);

  @override
  State<Water_Unit_Detail> createState() => _Water_Unit_DetailState();
}

class _Water_Unit_DetailState extends State<Water_Unit_Detail> {
  var waterUnitController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late WriteUnit_Request _writeUnit_Request;
  bool circleHUD = false;
  bool checkDept = false;
  late final Future<User_Consume_Data> futureUser;
  bool isChecked = false;
  MonthTH m = MonthTH();
  final _statusRadio = ["ปกติ", "รอบใหม่", "มาตรใหม่", "มาตรชำรุด"];

  @override
  void initState() {
    checkInternet(context);
    circleHUD = false;
    _writeUnit_Request = WriteUnit_Request();
    futureUser = fetch_user_consume(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ProgressHUD(
        child: _uiSetUp(context), inAsyncCall: circleHUD, opacity: 0.3);
  }

  @override
  Widget _uiSetUp(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Palette.thisGreen,
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                  context.read<RadioCheckBloc>().add(ClearRadioDefault());
                },
                child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.arrow_back_ios_new))),
            const SizedBox(
              width: 70,
            ),
            const Text('จดมาตรวัดน้ำ'),
          ],
        ),
      ),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CustomPaint(
                    painter: ShapesPainter(),
                    child: Container(height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        children: [

                          FutureBuilder<User_Consume_Data>(
                            future: futureUser,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                User_Consume_Data? data = snapshot.data;
                                var debtLength = data!.historyInvoices!.length;
                                

                                if (debtLength == 0) {
                                  checkDept = false;
                                } else {
                                  checkDept = true;
                                }

                                return Column(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 245, 245, 245),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              data.customerWater!.name
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'บ้านเลขที่ ' +
                                                  data.customerWater!.address
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 83, 83, 83)),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'มาตรวัดน้ำ:',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 83, 83, 83)),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          color: Color.fromARGB(
                                                              255,
                                                              221,
                                                              221,
                                                              221)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5, right: 5),
                                                    child: Text(
                                                      data.customerWater!
                                                          .meterNumber
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 83, 83, 83)),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          color: Color.fromARGB(
                                                              255,
                                                              221,
                                                              221,
                                                              221)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5, right: 5),
                                                    child: Text(
                                                      data.waterNumber
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 83, 83, 83)),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          color: Color.fromARGB(
                                                              255,
                                                              221,
                                                              221,
                                                              221)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5, right: 5),
                                                    child: Text(
                                                      data.areaNumber
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                    checkDept
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.maxFinite,
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(
                                                        width: 5.0,
                                                        color:
                                                            Palette.thisGreen),
                                                  ),
                                                ),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5.0),
                                                        child: Text(
                                                          'ประวัติค้างชำระ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      101,
                                                                      101,
                                                                      101),
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
                                                  color: Color.fromARGB(
                                                      255, 230, 95, 85),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'เดือน',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      
                                                      const Text('หน่วย',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      
                                                      const Text('จำนวนเงิน',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  itemCount: data
                                                      .historyInvoices!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 245, 245, 245),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Row(
                                                     
                                                          children: [
                                                            Container(
                                                              width: 110,
                                                              child: Text(
                                                                data.historyInvoices![index].water_meter_record !=
                                                                        null
                                                                    ? 
                                                                    
                                                                    data
                                                                        .historyInvoices![
                                                                            index]
                                                                        .water_meter_record!
                                                                        .recordDateFormat
                                                                        .toString()
                                                                    : '-',
                                                                style: const TextStyle(
                                                                    fontSize: 18,
                                                                    color: Palette
                                                                        .thisGreen,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
           const SizedBox(width: 20,),
                                                            Container(
                                                              width: 75,
                                                              child: Text(
                                                                    data.historyInvoices![index].water_meter_record !=
                                                                        null
                                                                    ? data
                                                                        .historyInvoices![
                                                                            index]
                                                                        .water_meter_record!
                                                                        .sumUnit
                                                                        .toString()
                                                                    : '-',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Palette
                                                                          .thisGreen,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ),
                                                            const SizedBox(width: 50,),
                                                            Container(
                                                              
                                                              child: Text(
                                                                  data
                                                                      .historyInvoices![
                                                                          index]
                                                                      .total
                                                                      .toString(),
                                                                      textAlign: TextAlign.end,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Palette
                                                                          .thisGreen,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                const Text(
                                          'เลขมาตรวัดน้ำที่แล้ว: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19),
                                        ),
                                        Text(
                                          data.previous_unit_format.toString(),
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Form(
                                        key: formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: waterUnitController,
                                              textAlign: TextAlign.left,
                                              autofocus: false,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              onSaved: (input) =>
                                                  _writeUnit_Request
                                                      .current_unit = input,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'โปรดกรอกเลขมาตรวัดน้ำก่อนการยืนยัน';
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'กรอกมาตรวัดน้ำปัจจุบัน',
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                filled: true,
                                                fillColor: const Color.fromARGB(
                                                    255, 238, 238, 238),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            BlocBuilder<RadioCheckBloc,
                                                RadioCheckState>(
                                              builder: (context, state) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'เลือกสถานะมาตร : ',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          state.writeCondition,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: state
                                                                      .colorCondition
                                                                  ? Palette
                                                                      .thisGreen
                                                                  : Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    RadioGroup<String>.builder(
                                                      textStyle: const TextStyle(
                                                          fontSize: 20),
                                                      groupValue:
                                                          state.writeCondition,
                                                      onChanged: (value) {
                                                        context
                                                            .read<
                                                                RadioCheckBloc>()
                                                            .add(CheckThisBro(
                                                                getCondiotionRadio:
                                                                    value
                                                                        .toString()));
                                                      },
                                                      items: _statusRadio,
                                                      itemBuilder: (item) =>
                                                          RadioButtonBuilder(
                                                        item,
                                                      ),
                                                      fillColor:
                                                          Palette.thisGreen,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Palette
                                                                  .thisGreen,
                                                              elevation: 0,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              )),
                                                      onPressed: () {
//*---------------------------------------------------------------------------------------------------------------------------

                                                        if (waterUnitController
                                                            .text.isNotEmpty) {
                                                          checkInternet(
                                                              context);
                                                          setState(() {
                                                            circleHUD = true;
                                                          });
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        }
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          formKey.currentState
                                                              ?.save();
                                                          if (state
                                                                  .writeCondition ==
                                                              "ปกติ") {
                                                            if (int.parse(data
                                                                    .previous_unit_format
                                                                    .toString()) >
                                                                int.parse(_writeUnit_Request
                                                                    .current_unit
                                                                    .toString())) {
                                                              _showAlertWrite_ERROR();
                                                            } else {
                                                              _writeUnit_Request
                                                                      .water_meter_record_id =
                                                                  widget.id
                                                                      .toString();
                                                              _writeUnit_Request
                                                                      .writeStatus =
                                                                  "0";
                                                            }

                                                            _showAlertWrite_OK(
                                                                _writeUnit_Request
                                                                    .current_unit
                                                                    .toString(),
                                                                state
                                                                    .writeCondition);
                                                          } else if (state
                                                                  .writeCondition ==
                                                              "รอบใหม่") {
                                                            _writeUnit_Request
                                                                    .water_meter_record_id =
                                                                widget.id
                                                                    .toString();
                                                            _writeUnit_Request
                                                                    .writeStatus =
                                                                "1";

                                                            _showAlertWrite_OK(
                                                                _writeUnit_Request
                                                                    .current_unit
                                                                    .toString(),
                                                                state
                                                                    .writeCondition);
                                                          } else if (state
                                                                  .writeCondition ==
                                                              "มาตรใหม่") {
                                                            _writeUnit_Request
                                                                    .water_meter_record_id =
                                                                widget.id
                                                                    .toString();
                                                            _writeUnit_Request
                                                                    .writeStatus =
                                                                "2";

                                                            _showAlertWrite_OK(
                                                                _writeUnit_Request
                                                                    .current_unit
                                                                    .toString(),
                                                                state
                                                                    .writeCondition);
                                                          } else {
                                                            _writeUnit_Request
                                                                    .water_meter_record_id =
                                                                widget.id
                                                                    .toString();
                                                            _writeUnit_Request
                                                                    .writeStatus =
                                                                "3";

                                                            _showAlertWrite_OK(
                                                                _writeUnit_Request
                                                                    .current_unit
                                                                    .toString(),
                                                                state
                                                                    .writeCondition);
                                                          }
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            "ยืนยัน",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        )),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Center(
                                        child: Text(
                                      snapshot.error.toString(),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )),
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
                                    color: Colors.white,
                                  )),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> write_unit(WriteUnit_Request write_requestModel) async {
    String urlPost = waterWork_domain + 'water_meter_record/update';

    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    var getThatToken = prefs2.get('keyToken');

    var body_unitWritten = json.encode(write_requestModel.toJson());
    final response = await http.post(
      Uri.parse(urlPost),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getThatToken',
      },
      body: body_unitWritten,
    );

    String jsonsDataString = response.body;
    var datax = json.decode(jsonsDataString);

    if (response.statusCode == 200 || response.statusCode == 400) {
      setState(() {
        circleHUD = false;
      });
      print('----------- write success, invoice id: ' +
          datax['data']['invoice']['id'].toString());
      //! bloc funtion clear
      context.read<NotWriteBloc>().add(Reload_Undone(context));
      context.read<DoneBloc>().add(Reload_Done(context));
      context.read<CheckboxBloc>().add(ClearCheck());
      context.read<RadioCheckBloc>().add(ClearRadioDefault());

      Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 100),
            type: PageTransitionType.rightToLeft,
            child: Invoice_Page(
              invoiceID: datax['data']['invoice']['id'].toString(),
            )),
      );
    } else {
      setState(() {
        circleHUD = false;
      });
      print('----------- write water failed -----------');
      print(response.body);
    }
  }

  Future<void> _showAlertWrite_ERROR() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ไม่สามารถจดหน่วยน้ำได้ !',
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "เลขมาตรวัดน้ำปัจจุบันน้อยกว่าครั้งก่อน",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text('โปรดตรวจสอบและจดใหม่อีกครั้ง')
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: Text(
                  'เข้าใจแล้ว, ต่อไปฉันจะดูให้ดี',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                setState(() {
                  circleHUD = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAlertWrite_OK(String newUnit, String newStatus) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('โปรดตรวจสอบความถูกต้อง'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "เลขมาตรวัดน้ำ: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "${newUnit}",
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      newStatus,
                      style:
                          const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'ยกเลิก',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                setState(() {
                  circleHUD = false;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ยืนยัน'),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  final result = await InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    //print('connected');
                    write_unit(_writeUnit_Request); //original
                  }
                } on SocketException catch (_) {
                  print('not connected');
                  showMyDialog(
                    context,
                    () {
                      Navigator.pop(context);
                      loadingInternet();
                      Future.delayed(const Duration(seconds: 3), () {
                        checkInternet(context);
                      });
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
