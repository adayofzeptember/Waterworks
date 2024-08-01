import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'color_green.dart';
//!รายการหน่วยน้ำผิดปกติ
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
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.arrow_back_ios_new,
                        color: Palette.thisGreen))),
            const SizedBox(
              width: 50,
            ),
            const Text(
              'ใบแจ้งหน่วยน้ำผิดปกติ',
              style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Container(
                width: double.infinity,
                child: 
                SvgPicture.asset(
                  'assets/images/irr.svg',
                  fit: BoxFit.cover,
                )
                ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.thisGreen,
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
                  child: const Text(
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
