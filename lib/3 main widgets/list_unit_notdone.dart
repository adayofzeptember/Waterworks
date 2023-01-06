import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/user_consume_info.dart';
import 'package:waterworks/write_water_unit_info.dart';
import '../write_water_unit_info.dart';

class Notyet extends StatefulWidget {

  Notyet({Key? key}) : super(key: key);

  @override
  State<Notyet> createState() => _NotyetState();
}

class _NotyetState extends State<Notyet> {
  String? selectedValue;
  List<String> districItems = [
    'ในเมือง',
    'นครราชสีมา',
  ];

  List<String> epItems = ['ตอน 1', 'ตอน 2', 'ตอน 3'];
//!----------------------------------
  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
  ];
//!----------------------------------

  List data = [];
  ScrollController _scrollController = ScrollController();

  final rawGreenScrollBar = ScrollController();
  final scrollController = ScrollController();
  final singleChildScrollController = ScrollController();
  int page = 1;
  bool isLoadingMore = false;
  @override
  void initState() {
    fetch_unit_notDone();
    scrollController.addListener(_scrollListener);
    singleChildScrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: singleChildScrollController,
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
              ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: isLoadingMore ? data.length + 1 : data.length,
                  itemBuilder: (context, index,) {
                    
                    if (index < data.length) {
                      final post = data[index];

              
                      final user_id = post['id'].toString();
                      final user_name = post['user_name'];
                      final water_number = post['water_number'];
                      final area_number = post['area_number'];
                      final address = post['customer_water']['address'];
                      var meter_number =
                          post['customer_water']['meter_number'].toString();

                      if (meter_number == 'null') {
                        meter_number = '00';
                      }
                      

                      return Container(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0)),
                              child: InkWell(
                                onTap: () {
     
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      duration: Duration(milliseconds: 250),
                                      type: PageTransitionType.rightToLeft,
                                      child: Use_Water_Info(id: user_id,),
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
                                          width: 10.0, color: Colors.grey),
                                    ),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                address,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                user_name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 83, 83, 83),
                                                    fontSize: 18),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'มาตรวัดน้ำ:',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                          EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      child: Text(
                                                        meter_number,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'เลข ป.',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                          EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      child: Text(
                                                        water_number,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            color:
                                                                Colors.black),
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                          EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      child: Text(
                                                        area_number,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            color:
                                                                Colors.black),
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
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                duration: Duration(
                                                    milliseconds: 250),
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: Water_Unit_Detail(id: user_id.toString(),),
                                              ),
                                            );
                                          }),
                                          child: Container(
                                            width: 110,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.all(
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
                                                  'จดมาตรวัดน้ำ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                          ],
                        ),
                      );
                    } 
                    else {
                      return Center(
                        child: CircularProgressIndicator(color: Palette.thisGreen,),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetch_unit_notDone() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    var getThatToken = prefs2.get('keyToken');
    print(getThatToken.toString() + '+++++++++++++++++++++++++++++++++++++');

  
    final response = await http.get(
      Uri.parse(waterWork_domain +
          'water_meter_record/index?per_page=10&status=pending&page=${page}'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $getThatToken',
      },
    );
    var jsonResponse = json.decode(response.body);
    final jsonCon = jsonResponse['data']['data'] as List;
    if (response.statusCode == 200) {
      //print(response.body);
      setState(() {
        data = data + jsonCon;
      });
      //print(data[1]['title']);
    } else {
      throw Exception("error...");
    }
  }

  Future<void> _scrollListener() async {
    if (isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      singleChildScrollController.addListener(_scrollListener);

      setState(() {
        isLoadingMore = true;
      });
      page = page + 1;

      await fetch_unit_notDone();
      setState(() {
        isLoadingMore = false;
      });
    }
  }

}
