import 'dart:convert';
import 'dart:io';
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
import '../offline/utils.dart';
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
//!-----------------------------------------------------
  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
  ];
//!------------------------------------------------------

  List data = [];
  ScrollController _scrollController = ScrollController();

  final rawGreenScrollBar = ScrollController();
  final scrollController = ScrollController();
  final singleChildScrollController = ScrollController();
  int page = 1;
  bool isLoadingMore = false;
  @override
  void initState() {
    check();
    //fetch_unit_notDone();
    scrollController.addListener(_scrollListener);
    singleChildScrollController.addListener(_scrollListener);

    super.initState();
  }

  void check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        fetch_unit_notDone();
      }
    } on SocketException catch (_) {
      print('not connected');
      showMyDialog(
        context,
        () {
          Navigator.pop(context);
          loadingInternet();
          Future.delayed(const Duration(seconds: 3), () {
            checkInternet(context);
          });
        },
      );
    }
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
                      final user_name = post['customer_water']['name'];
                      final water_number = post['water_number'];
                      final area_number = post['area_number'];
                      final address = post['customer_water']['address'];
                      bool statusCheck = true;
                      var status = post['customer_water']['status'].toString();
                      var meter_number =
                          post['customer_water']['meter_number'].toString();

                      if (meter_number == 'null') {
                        meter_number = '00';
                      }
                      if (status == "Normal") {
                        statusCheck = false;
                      }

                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: InkWell(
                              onTap: () {
                                print('user id: ' + user_id);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: Duration(milliseconds: 250),
                                    type: PageTransitionType.rightToLeft,
                                    child: Use_Water_Info(
                                      id: user_id,
                                    ),
                                  ),
                                );
                                ;
                              },
                              child: Container(
                                height: 150,
                                width: double.maxFinite,
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    left: BorderSide(
                                        width: 10.0, color: Palette.thisGreen),
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
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  child: Text(
                                                    'เลข ป. ' + water_number,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 240, 41, 27)),
                                                  ),
                                                ),
                                                statusCheck
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      230,
                                                                      87,
                                                                      87)),
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'ตัดมาตร',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ],
                                                              )

                                                              // Text(
                                                              //   'โดนปิด',
                                                              //   style: TextStyle(
                                                              //       fontSize: 13,
                                                              //       fontWeight:
                                                              //           FontWeight
                                                              //               .bold,
                                                              //       color: Colors
                                                              //           .black),
                                                              // ),
                                                              ),
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                            Container(
                                              width: 200,
                                              child: Text(
                                                user_name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                          255, 221, 221, 221)),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5, right: 5),
                                                    child: Text(
                                                      address,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
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
                                                          255, 221, 221, 221)),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5, right: 5),
                                                    child: Text(
                                                      meter_number,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
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
                                                          255, 221, 221, 221)),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5, right: 5),
                                                    child: Text(
                                                      area_number,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (() {
                                          print("user water id: " +
                                              user_id.toString());

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
                                          width: 130,
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
                                              Image.asset(
                                                'assets/images/meter.png',
                                                height: 75,
                                                width: 75,
                                              ),

                                              // SvgPicture.asset(
                                              //   'assets/images/meter2.svg',
                                              //   height: 50,
                                              // ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'จดมาตรวัดน้ำ',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
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
                      );
                    } else if (index == data.length) {
                      return Center(child: Text('...'));
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

    String jsonsDataString = response.body;
    var datax = json.decode(jsonsDataString);
    // var jsonResponse = json.decode(response.body);  เอาตัวนีี้ไปแทน datax
    final jsonCon = datax['data']['data'] as List;
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
