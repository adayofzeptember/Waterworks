import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/print%20pages/recipt_info.dart';

//! จดมาตราวัดน้ำ
class Water_Unit_Detail extends StatefulWidget {
  Water_Unit_Detail({Key? key}) : super(key: key);

  @override
  State<Water_Unit_Detail> createState() => _Water_Unit_DetailState();
}

class _Water_Unit_DetailState extends State<Water_Unit_Detail> {
  var waterUnitController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            Text('จดมาตราวัดน้ำ'),
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
                        Container(
                          decoration: BoxDecoration(
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
                                  'คุณชวันธร วีรจรรยาพันธ์',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
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
                                          color:
                                              Color.fromARGB(255, 83, 83, 83)),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Color.fromARGB(
                                              255, 221, 221, 221)),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
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
                                          color:
                                              Color.fromARGB(255, 83, 83, 83)),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Color.fromARGB(
                                              255, 221, 221, 221)),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
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
                                          color:
                                              Color.fromARGB(255, 83, 83, 83)),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Color.fromARGB(
                                              255, 221, 221, 221)),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
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
                              left: BorderSide(
                                  width: 5.0, color: Palette.thisGreen),
                            ),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'ประวัติค้างชำระ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 101, 101, 101),
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
                            color: Color.fromARGB(255, 237, 83, 83),
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
                                Container(
                                  color: Color.fromARGB(255, 255, 232, 232),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, right: 3),
                                    child: Text(
                                      '04/2565',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 233, 14, 14)),
                                    ),
                                  ),
                                ),
                                Text('283',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 233, 14, 14))),
                                Text('453.13',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 233, 14, 14))),
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
                                Container(
                                  color: Color.fromARGB(255, 255, 232, 232),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, right: 3),
                                    child: Text(
                                      '04/2565',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 233, 14, 14)),
                                    ),
                                  ),
                                ),
                                Text('283',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 233, 14, 14))),
                                Text('453.13',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 233, 14, 14))),
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
                                Container(
                                  color: Color.fromARGB(255, 255, 232, 232),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, right: 3),
                                    child: Text(
                                      '04/2565',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 233, 14, 14)),
                                    ),
                                  ),
                                ),
                                Text('283',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 233, 14, 14))),
                                Text('453.13',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 233, 14, 14))),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  onSaved: (input) => print(input),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'โปรดกรอกเลขมาตราวัดน้ำก่อนการยืนยัน';
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'กรอกเลขมาตราวัดน้ำ',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 238, 238, 238),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20.0),
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
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState?.save();
                                      showDialog();
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   PageTransition(
                                      //     duration: Duration(milliseconds: 250),
                                      //     type: PageTransitionType.rightToLeft,
                                      //     child: Recipt_Info(),
                                      //   ),
                                      // );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "ยืนยัน",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
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

  void showDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoAlertDialog(
            title: Text(
              "โปรดตรวจสอบความถูกต้องของมาตราวัดน้ำก่อนยืนยัน",
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "ต้องการยืนยันใช่หรือไม่",
                style: TextStyle(fontFamily: 'Kanit'),
                textAlign: TextAlign.start,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                  child: Text(
                    "ยกเลิก",
                    style: TextStyle(fontFamily: 'Kanit',color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              CupertinoDialogAction(
                child: Text(
                  "ยืนยัน",
                  style: TextStyle(fontFamily: 'Kanit'),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 250),
                      type: PageTransitionType.rightToLeft,
                      child: Recipt_Info(),
                    ),
                  );
                },
              )
            ],
          ),
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
