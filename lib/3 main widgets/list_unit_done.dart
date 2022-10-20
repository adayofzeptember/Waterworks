import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/user_consume_info.dart';
import 'package:waterworks/water_unit_info.dart';
import '../water_unit_info.dart';

class Done extends StatefulWidget {
  Done({Key? key}) : super(key: key);

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  List<String> districItems = [
    'ในเมือง',
    'นครราชสีมา',
  ];

  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
  ];

  List<String> epItems = ['ตอน 1', 'ตอน 2', 'ตอน 3'];

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: DropdownButtonFormField2(
                      focusColor: Palette.thisGreen,
                      decoration: InputDecoration(
                        focusColor: Palette.thisGreen,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'เขต',
                        style: TextStyle(fontSize: 20),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 50,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: districItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                      },
                      onChanged: (value) {},
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 180,
                    child: DropdownButtonFormField2(
                      iconEnabledColor: Palette.thisGreen,
                      decoration: InputDecoration(
                        focusColor: Palette.thisGreen,
                        fillColor: Palette.thisGreen,
                        hoverColor: Palette.thisGreen,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Palette.thisGreen)),
                      ),
                      isExpanded: true,
                      focusColor: Palette.thisGreen,
                      hint: const Text(
                        'ตอน',
                        style: TextStyle(fontSize: 20),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 50,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: epItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {}
                      },
                      onChanged: (value) {},
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: Duration(milliseconds: 250),
                              type: PageTransitionType.rightToLeft,
                              child: Use_Water_Info(),
                            ),
                          );
                          ;
                        },
                        child: Container(
                          height: 110,
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              left: BorderSide(
                                width: 10.0,
                                color: Palette.thisGreen,
                              ),
                            ),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        '14/852',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 6, 148, 93),
                                            fontSize: 20),
                                      ),
                                      Text(
                                        'คุณชวันธร วีรจรรยาพันธ์',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 83, 83, 83),
                                            fontSize: 18),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'มาตราวัดน้ำ:',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 83, 83, 83)),
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
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text(
                                                '12345',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            'เลข ป.',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 83, 83, 83)),
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
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text(
                                                '00',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            'เขต',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 83, 83, 83)),
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
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text(
                                                '00',
                                                style: TextStyle(
                                                    fontSize: 13,
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
                                InkWell(
                                  onTap: (() {
                                    Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        duration: Duration(milliseconds: 250),
                                        type: PageTransitionType.rightToLeft,
                                        child: Water_Unit_Detail(),
                                      ),
                                    );
                                  }),
                                  child: Container(
                                    width: 110,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Palette.thisGreen,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/dripping.svg'),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'จดมาตราวัดน้ำ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: Container(
                        height: 110,
                        width: double.maxFinite,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              width: 10.0,
                              color: Palette.thisGreen,
                            ),
                          ),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '555/87',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 6, 148, 93),
                                          fontSize: 20),
                                    ),
                                    Text(
                                      'John Bonhnam',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 83, 83, 83),
                                          fontSize: 18),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'มาตราวัดน้ำ:',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 83, 83, 83)),
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
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                              '222111',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'เลข ป.',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 83, 83, 83)),
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
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                              '00',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'เขต',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 83, 83, 83)),
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
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                              '00',
                                              style: TextStyle(
                                                  fontSize: 13,
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
                              Container(
                                width: 110,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    color: Palette.thisGreen,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/dripping.svg'),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'จดมาตราวัดน้ำ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: Container(
                        height: 110,
                        width: double.maxFinite,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              width: 10.0,
                              color: Palette.thisGreen,
                            ),
                          ),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '212/224',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 6, 148, 93),
                                          fontSize: 20),
                                    ),
                                    Text(
                                      'Killswitch Engage',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 83, 83, 83),
                                          fontSize: 18),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'มาตราวัดน้ำ:',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 83, 83, 83)),
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
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                              '332111',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'เลข ป.',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 83, 83, 83)),
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
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                              '00',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'เขต',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 83, 83, 83)),
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
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                              '00',
                                              style: TextStyle(
                                                  fontSize: 13,
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
                              Container(
                                width: 110,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    color: Palette.thisGreen,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/dripping.svg'),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'จดมาตราวัดน้ำ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
