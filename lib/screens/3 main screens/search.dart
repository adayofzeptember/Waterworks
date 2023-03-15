import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:waterworks/bloc/search/search_bloc.dart';

import '../user_consume_info.dart';
import '../write_water_unit_info.dart';


class Search_Page extends StatelessWidget {
  Search_Page({Key? key}) : super(key: key);
  
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onSubmitted: ((value) {
                context
                    .read<SearchBloc>()
                    .add(SearchNumber(searchNumber: value));
              }),
              decoration: InputDecoration(
                  labelText: "ค้นหาด้วยเลข ป. ",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(230.0)))),
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.statusSearch == "0") {
                  return CircularProgressIndicator();
                }
                if (state.statusSearch == "1") {
                  return Text('ระบุข้อมูล');
                }

                if (state.statusSearch == "2") {
                  return Column(
                    children: [
                      Text('ตรวจสอบสัญญาณเครือข่าย', style: TextStyle(color: Colors.red),),
                      Text(state.error.toString()),
                    ],
                  );
                }

                if (state.searchResult.isEmpty) {
                  return Text(state.statusSearch.toString());
                  //* 
                }

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.searchResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: InkWell(
                              onTap: () {
                                print(
                                  'เลข ป.${state.searchResult[index].waterNumber}',
                                );
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: Duration(milliseconds: 250),
                                    type: PageTransitionType.rightToLeft,
                                    child: Use_Water_Info(
                                      id: state.searchResult[index].id
                                          .toString(),
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
                                                    'เลข ป. ' +
                                                        state
                                                            .searchResult[index]
                                                            .waterNumber
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 240, 41, 27)),
                                                  ),
                                                ),
                                                state.searchResult[index]
                                                            .status !=
                                                        true
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
                                                              )),
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                            Container(
                                              width: 200,
                                              child: Text(
                                                state.searchResult[index]
                                                    .customerName,
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
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 83, 83, 83)),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5, right: 5),
                                                    child: Text(
                                                      state.searchResult[index]
                                                          .customerAddress,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 15,
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
                                                      state.searchResult[index]
                                                          .meterNumber,
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
                                                      state.searchResult[index]
                                                          .areaNumber,
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
                                          print(state.searchResult[index].id
                                              .toString());

                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              duration:
                                                  Duration(milliseconds: 250),
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: Water_Unit_Detail(
                                                id: state.searchResult[index].id
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        }),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
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
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
