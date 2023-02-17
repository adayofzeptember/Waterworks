import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/API/post_WRITEwaterUnit.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/printable%20pages/invoice.dart';
import 'API/get_user_consume.dart';
import 'ETC/progressHUD.dart';

class Water_Unit_Detail extends StatefulWidget {
  String? id = '';
  Water_Unit_Detail({Key? key, this.id}) : super(key: key);

  @override
  State<Water_Unit_Detail> createState() => _Water_Unit_DetailState();
}

class _Water_Unit_DetailState extends State<Water_Unit_Detail> {
  var waterUnitController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late WriteUnit_Request _writeUnit_Request;
  bool circleHUD = false;

  @override
  void initState() {
    circleHUD = false;
    _writeUnit_Request = WriteUnit_Request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
                },
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.arrow_back_ios_new))),
            SizedBox(
              width: 70,
            ),
            Text('จดมาตรวัดน้ำ'),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
                          future: fetch_user_consume(widget.id.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              User_Consume_Data? data = snapshot.data;

                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 245, 245, 245),
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
                                            data!.customerWater!.name
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'บ้านเลขที่ ' +
                                                data.customerWater!.address
                                                    .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 83, 83, 83)),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'มาตรวัดน้ำ:',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 83, 83, 83)),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    color: Color.fromARGB(
                                                        255, 221, 221, 221)),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: Text(
                                                    data.customerWater!
                                                        .meterNumber
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                    color: Color.fromARGB(
                                                        255, 83, 83, 83)),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    color: Color.fromARGB(
                                                        255, 221, 221, 221)),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: Text(
                                                    data.waterNumber.toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                    color: Color.fromARGB(
                                                        255, 83, 83, 83)),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    color: Color.fromARGB(
                                                        255, 221, 221, 221)),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: Text(
                                                    data.areaNumber.toString(),
                                                    style: TextStyle(
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: waterUnitController,
                                            textAlign: TextAlign.left,
                                            autofocus: false,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            onSaved: (input) =>
                                                _writeUnit_Request
                                                    .current_unit = input,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'โปรดกรอกเลขมาตรวัดน้ำก่อนการยืนยัน';
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: 'กรอกเลขมาตรวัดน้ำ',
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              filled: true,
                                              fillColor: Color.fromARGB(
                                                  255, 238, 238, 238),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
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
                                              setState(() {
                                                circleHUD = true;
                                              });
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                              
                                              if (formKey.currentState!
                                                  .validate()) {
                                                formKey.currentState?.save();
                              
                                                _writeUnit_Request
                                                        .water_meter_record_id =
                                                    widget.id.toString();
                              
                                                // showDialog(_writeUnit_Request
                                                //     .current_unit
                                                //     .toString());
                              
                                                _showAlertDialog(
                                                    _writeUnit_Request
                                                        .current_unit
                                                        .toString());
                              
                                                // print(jsonEncode(
                                                //     _writeUnit_Request));
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "ยืนยัน",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              );
                            }
                            return Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Center(
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
    );
  }

  Future<Data_writeUnit> write_unit(
      WriteUnit_Request write_requestModel) async {
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
      print('----------- write water success -----------');
      print('invoice id: ' + datax['data']['invoice']['id'].toString());

      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        backgroundColor: Color.fromARGB(255, 65, 158, 68),
        elevation: 0,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'จดหน่วยน้ำเสร็จสิ้น ',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Icon(
              Icons.check,
              color: Colors.white,
            )
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
      ));
      Navigator.push(
        context,
        PageTransition(
            duration: Duration(milliseconds: 100),
            type: PageTransitionType.rightToLeft,
            child: Invoice_Page(
              invoiceID: datax['data']['invoice']['id'].toString(),
            )),
      );

      return Data_writeUnit.fromJson(json.decode(response.body));
    } else {
      setState(() {
        circleHUD = false;
      });
      print('----------- write water failed -----------');
      print(response.body);
      throw Exception();
    }
  }

  Future<void> _showAlertDialog(String newUnit) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('โปรดตรวจสอบความถูกต้อง'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "เลขมาตรวัดน้ำ: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "${newUnit}",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
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
              onPressed: () {
                Navigator.of(context).pop();
                write_unit(_writeUnit_Request);
              },
            ),
          ],
        );
      },
    );
  }
}

const double _kCurveHeight = 50;

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    final path = Path();
    p.lineTo(0, size.height - _kCurveHeight);
    p.relativeQuadraticBezierTo(
        size.width / 2, 2 * _kCurveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();
    canvas.drawPath(p, Paint()..color = Palette.thisGreen);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
