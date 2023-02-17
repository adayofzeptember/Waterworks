import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:waterworks/user_consume_info.dart';
import 'package:waterworks/write_water_unit_info.dart';

class Search_Page extends StatefulWidget {
  Search_Page({Key? key}) : super(key: key);

  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  bool haveSearched = false;
  bool searchLoad = false;
  String searchWord = '';
  List data = [];
  ScrollController _scrollController = ScrollController();
  final rawdGreenScrollBar = ScrollController();
  final scrollController = ScrollController();
  final singleChildScrollController = ScrollController();
  int page = 1;
  int checkSearch = 0;
  bool isLoadingMore = false;

  @override
  void initState() {
    haveSearched = false;
    scrollController.addListener(_scrollListener);
    singleChildScrollController.addListener(_scrollListener);
    super.initState();
  }

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'ค้นหา',
            style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
          ),
        ),
      ),
      body: SingleChildScrollView(
          controller: singleChildScrollController,
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onSubmitted: ((value) {
                    if (value != '') {
                      setState(() {
                        checkSearch = 1;
                        searchLoad = true;
                        haveSearched = true;
                        searchWord = value.toString();
                      });
                      fetch_unit_searched();
                    }
                  }),
                  decoration: InputDecoration(
                      labelText: "ค้นหาด้วยที่อยู่, บ้านเลขที่",
                      // hintText: "ค้นหาด้วยที่อยู่, บ้านเลขที่",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(230.0)))),
                ),
                SizedBox(
                  height: 10,
                ),
                searchLoad
                    ? Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : haveSearched
                        ? 
                        
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
                      var meter_number =
                          post['customer_water']['meter_number'].toString();

                      if (meter_number == 'null') {
                        meter_number = '00';
                      }

                      return Column(
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
                  })
                        : Text('')
              ],
            ),
          )),
    );
  }

  Future<void> fetch_unit_searched() async {
    data.clear();
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    var getThatToken = prefs2.get('keyToken');

    final response = await http.get(
      Uri.parse(waterWork_domain +
          'water_meter_record/index?per_page=10&status=pending&search=${searchWord}&page=${page}'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $getThatToken',
      },
    );
    var jsonResponse = json.decode(response.body);
    final jsonCon = jsonResponse['data']['data'] as List;
    if (response.statusCode == 200) {
      setState(() {
        data = data + jsonCon;
        checkSearch = 0;
        searchLoad = false;
      });
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

      await fetch_unit_searched();
      setState(() {
        isLoadingMore = false;
      });
    }
  }
}
