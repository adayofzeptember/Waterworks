import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/water_unit_info.dart';

import '../ETC/color_green.dart';

class Irregular_Water extends StatefulWidget {
  Irregular_Water({Key? key}) : super(key: key);

  @override
  State<Irregular_Water> createState() => _Irregular_WaterState();
}

class _Irregular_WaterState extends State<Irregular_Water> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Palette.thisGreen,
                )),
            Text(
              'ใบแจ้งหน่วยน้ำผิดปกติ',
              style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
            ),
            Text(''),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Container(
                width: double.infinity,
                child: SvgPicture.asset(
                  'assets/images/irr.svg',
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 10,
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
          ]),
        ),
      ),
    );
  }
}
