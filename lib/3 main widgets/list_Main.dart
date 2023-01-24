import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/3%20main%20widgets/list_unit_done.dart';
import 'package:waterworks/3%20main%20widgets/list_unit_notdone.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/user_consume_info.dart';
import 'package:waterworks/write_water_unit_info.dart';
class Water_Unit_List extends StatefulWidget {
  Water_Unit_List({Key? key}) : super(key: key);

  @override
  State<Water_Unit_List> createState() => _Water_Unit_ListState();
}

class _Water_Unit_ListState extends State<Water_Unit_List> {
  List<String> districItems = [
    'ในเมือง',
    'เขตที่ 1 เมืองนครราชสีมา'
        'นครราชสีมา',
  ];

  List<String> epItems = ['ตอน1', 'ตอน2', 'ตอน3'];

  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
  ];

  String? selectedValue;
  String? xs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
     
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Palette.thisGreen,
            labelColor: Palette.thisGreen,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: ("ยังไม่จด"),
              ),
              Tab(
                text: ("จดแล้ว"),
              ),
            ],
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'รายการจดหน่วยน้ำ',
              style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
            ),
          ),
        ),
        body: TabBarView(
          children: [Notyet(), Done()],
        ),
      ),
    );
  }
}
