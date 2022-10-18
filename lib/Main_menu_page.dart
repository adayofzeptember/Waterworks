import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/3%20main%20widgets/profile.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/test.dart';
import 'package:waterworks/user_consume_info.dart';
import 'package:waterworks/water_unit_info.dart';

import '3 main widgets/list_water_unit.dart';

class Menu_Page extends StatefulWidget {
  Menu_Page({Key? key}) : super(key: key);

  @override
  State<Menu_Page> createState() => _Menu_PageState();
}

class _Menu_PageState extends State<Menu_Page> {
  List<String> districItems = [
    'ในเมือง',
    'นครราชสีมา55',
  ];

  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
  ];
  List<Widget> _widgetsPages = [Water_Unit_List(), xxx(), Profile()];
  int _index = 0;
  void _onItemTapped(int index2) {
    setState(() {
      _index = index2;
    });
  }

  List<String> epItems = ['ตอน 1', 'ตอน 2', 'ตอน 3'];

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetsPages.elementAt(_index),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset.zero),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                  size: 40,
                  color: Palette.thisGreen,
                ),
                icon: Icon(
                  Icons.house_sharp,
                  size: 40,
                ),
                label: 'หน้าหลัก'),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor: Palette.thisGreen,
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                label: 'ค้นหา'),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.person,
                  size: 40,
                  color: Palette.thisGreen,
                ),
                icon: Icon(
                  Icons.person,
                  size: 40,
                ),
                label: 'บัญชี')
          ],
        ),
      ),
    );
  }
}
