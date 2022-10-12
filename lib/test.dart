import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/water_unit_info.dart';

import '../ETC/color_green.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
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
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 0),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: SizedBox(
                  child: SvgPicture.asset(
                    "assets/images/new/tab1.svg",
                  ),
                ),
                icon: SizedBox(
                  child: SvgPicture.asset(
                    "assets/images/new/tab1.svg",
                  ),
                ),
                label: 'หน้าหลัก',
              ),
              BottomNavigationBarItem(
                activeIcon: SizedBox(
                  child: SvgPicture.asset(
                    "assets/images/new/tab3.svg",
                  ),
                ),
                icon: SizedBox(
                  child: SvgPicture.asset(
                    "assets/images/new/tab3.svg",
                  ),
                ),
                label: 'ค้นหา',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: SvgPicture.asset(
                    "assets/images/new/tab4.svg",
                  ),
                ),
                activeIcon: SizedBox(
                  child: SvgPicture.asset(
                    "assets/images/new/tab4.svg",
                  ),
                ),
                label: 'บัญชี',
              ),
            ],
          ),
        ));
  }
}
