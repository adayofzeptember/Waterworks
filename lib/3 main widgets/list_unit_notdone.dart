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

// mounted

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
    if (data.length == 0) {
      return Scaffold(
       
          body: Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            color: Palette.thisGreen,
          ),
        ),
      ));
    }

    return Scaffold(
      body: SingleChildScrollView(
        controller: singleChildScrollController,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: isLoadingMore ? data.length + 1 : data.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    if (index < data.length) {
                      final post = data[index];

                      final user_id = post['id'].toString();
                      final user_name =
                          post['customer_water']['customer']['name'];
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   PageTransition(
                                  //     duration: Duration(milliseconds: 250),
                                  //     type: PageTransitionType.rightToLeft,
                                  //     child: Use_Water_Info(
                                  //       id: user_id,
                                  //     ),
                                  //   ),
                                  // );
                                  ;
                                },
                                child: Container(
                                  
                                  height: 130,
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      left: BorderSide(
                                          width: 15.0, color: Colors.grey),
                                    ),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   'เลข ป.',
                                                  //   style: TextStyle(
                                                  //       fontSize: 20,
                                                  //       fontWeight:
                                                  //           FontWeight.bold,
                                                  //       color: Color.fromARGB(
                                                  //           255, 83, 83, 83)),
                                                  // ),
                                                  // SizedBox(
                                                  //   width: 5,
                                                  // ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        color: Colors.black),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5, right: 5),
                                                      child: Text(
                                                        'เลข ป. ' +
                                                            water_number,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  user_name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 83, 83, 83),
                                                      fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'ที่อยู่:',
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
                                                                Radius.circular(
                                                                    5)),
                                                        color: Color.fromARGB(
                                                            255,
                                                            221,
                                                            221,
                                                            221)),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5, right: 5),
                                                      child: Text(
                                                        address,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
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
                                                                Radius.circular(
                                                                    5)),
                                                        color: Color.fromARGB(
                                                            255,
                                                            221,
                                                            221,
                                                            221)),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5, right: 5),
                                                      child: Text(
                                                        meter_number,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
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
                                                                Radius.circular(
                                                                    5)),
                                                        color: Color.fromARGB(
                                                            255,
                                                            221,
                                                            221,
                                                            221)),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5, right: 5),
                                                      child: Text(
                                                        area_number,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                duration:
                                                    Duration(milliseconds: 250),
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: Water_Unit_Detail(
                                                  id: user_id.toString(),
                                                ),
                                              ),
                                            );
                                          }),
                                          child: Container(
                                            width: 120,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/droplet.svg',
                                                  height: 40,
                                                  color: Color.fromARGB(
                                                      255, 228, 228, 228),
                                                ),
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
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Palette.thisGreen,
                        ),
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

      if (this.mounted) {
        setState(() {
          data = data + jsonCon;
        });
      }
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

      if (this.mounted) {
        setState(() {
          isLoadingMore = true;
        });
      }
      page = page + 1;

      await fetch_unit_notDone();

      if (this.mounted) {
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }
}
