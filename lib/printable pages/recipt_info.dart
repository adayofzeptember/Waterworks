import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sweetalertv2/sweetalertv2.dart';
import 'package:waterworks/printable%20pages/water_unit_irregular.dart';
import 'package:waterworks/water_unit_info.dart';
import '../ETC/color_green.dart';

//!ใบแจ้งหนี้
class Recipt_Info extends StatefulWidget {
  Recipt_Info({Key? key}) : super(key: key);

  @override
  State<Recipt_Info> createState() => _Recipt_InfoState();
}

class _Recipt_InfoState extends State<Recipt_Info> {
  @override
  void initState() {

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
                  Navigator.pop(context);
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
              'ใบแจ้งนี้55',
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
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 250),
                      type: PageTransitionType.rightToLeft,
                      child: Irregular_Water(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 235, 192),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            color: Color.fromARGB(255, 216, 116, 0)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'หน่วยน้ำผิดปกติ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 98, 41, 0)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 232, 232),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/alert.svg',
                          color: Color.fromARGB(255, 255, 0, 0)),
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
                ),
              ),
              Container(
                  width: double.infinity,
                  child: SvgPicture.asset(
                    'assets/images/r2.svg',
                    fit: BoxFit.cover,
                  )),
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
}
