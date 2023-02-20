import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/user_consume_info.dart';
import 'package:waterworks/write_water_unit_info.dart';
import '../invoice.dart';
import '../write_water_unit_info.dart';

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

  List data = [];
  final scrollController = ScrollController();
  final singleChildScrollController = ScrollController();
  int page = 1;
  bool isLoadingMore = false;
  @override
  void initState() {
    fetch_unit_done();
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
          // width: 50,
          // height: 50,
          child: CircularProgressIndicator(
            color: Palette.thisGreen,
          ),
        ),
      ));
    }
    return SingleChildScrollView(
        controller: singleChildScrollController,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: isLoadingMore ? data.length + 1 : data.length,
                  itemBuilder: (context, index) {
                    if (index < data.length) {
                      final post = data[index];

                      var meter_number =
                          post['customer_water']['meter_number'].toString();

                      if (meter_number == 'null') {
                        meter_number = '00';
                      }

                      final user_id = post['id'].toString();
                      final user_name = post['customer_water']['name'];
                      ;
                      final water_number = post['water_number'];
                      final area_number = post['area_number'];
                      final address = post['customer_water']['address'];
                      String invoiceID = post['invoice']['id'].toString();
                      return InkWell(
                        onTap: () {
                          print('invoice id: ' + invoiceID);
                          print(invoiceID);
                          Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 100),
                                type: PageTransitionType.rightToLeft,
                                child: Invoice_Page(
                                  invoiceID: invoiceID,
                                )),
                          );
                        },
                        child: Container(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                child: Container(
                                  height: 130,
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      left: BorderSide(
                                          width: 15.0,
                                          color: Color.fromARGB(
                                              255, 233, 233, 233)),
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
                                                        color: Color.fromARGB(
                                                            255,
                                                            241,
                                                            241,
                                                            241)),
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
                                                            color:
                                                                Colors.black),
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
                                                            241,
                                                            241,
                                                            241)),
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
                                                            241,
                                                            241,
                                                            241)),
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
                                                            241,
                                                            241,
                                                            241)),
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
                                        Container(
                                          width: 115,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 241, 241, 241),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/done_icon.png',
                                                height: 50,
                                                color: Palette.thisGreen,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'จดมาตรวัดน้ำแล้ว',
                                                style: TextStyle(
                                                    color: Palette.thisGreen,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
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
                            ],
                          ),
                        ),
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
        ));
  }

  Future<void> fetch_unit_done() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    var getThatToken = prefs2.get('keyToken');
    print(getThatToken.toString());

    final response = await http.get(
      Uri.parse(waterWork_domain +
          'water_meter_record/index?per_page=10&status=processing&page=${page}'),
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

      await fetch_unit_done();
      setState(() {
        isLoadingMore = false;
      });
    }
  }
}
