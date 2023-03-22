import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:waterworks/bloc/search/search_bloc.dart';
import '../invoice_page.dart';
import 'dart:io';
import '../user_consume_info.dart';
import '../write_page.dart';

class Search_Page extends StatelessWidget {
  Search_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'ค้นหา',
            style: TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
          ),
        ),
      ),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: (Platform.isAndroid) ? TextInputType.number : TextInputType.text,
                onSubmitted: ((value) {
                  context
                      .read<SearchBloc>()
                      .add(SearchNumber(searchNumber: value));
                }),
                decoration: const InputDecoration(
                    labelText: "ค้นหาด้วยเลข ป. ",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(230.0)))),
              ),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.statusSearch == "0") {
                    return const CircularProgressIndicator();
                  }
                  if (state.statusSearch == "1") {
                    return const Text('ระบุเลข ป. ที่ต้องการค้นหา');
                  }

                  if (state.statusSearch == "2") {
                    return Column(
                      children: [
                        const Text(
                          'ตรวจสอบสัญญาณเครือข่าย',
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(state.error.toString()),
                      ],
                    );
                  }

                  if (state.searchResult.isEmpty) {
                    return Text(state.statusSearch.toString());
                    //*
                  }

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ผลการค้นหา: ',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            state.searchResult.length.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            ' รายการ',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.searchResult.length,
                        itemBuilder: (BuildContext context, int index) {
                          return state.searchResult[index].statusSearchCheck
                              ? Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0)),
                                      child: InkWell(
                                        onTap: () {
                                          print(
                                            'เลข ป.${state.searchResult[index].waterNumber}',
                                          );
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              duration: const Duration(
                                                  milliseconds: 250),
                                              type: PageTransitionType
                                                  .rightToLeft,
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              left: BorderSide(
                                                  width: 10.0,
                                                  color: Palette.thisGreen),
                                            ),
                                          ),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                            child: Text(
                                                              'เลข ป. ' +
                                                                  state
                                                                      .searchResult[
                                                                          index]
                                                                      .waterNumber
                                                                      .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          240,
                                                                          41,
                                                                          27)),
                                                            ),
                                                          ),
                                                          state.searchResult[index]
                                                                      .status !=
                                                                  true
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  child:
                                                                      Container(
                                                                    decoration: const BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                5)),
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            230,
                                                                            87,
                                                                            87)),
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.only(left: 5, right: 5),
                                                                        child: Row(
                                                                          children: [
                                                                            const Text(
                                                                              'ตัดมาตร',
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            const Icon(
                                                                              Icons.close,
                                                                              color: Colors.white,
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
                                                          state
                                                              .searchResult[
                                                                  index]
                                                              .customerName,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          83,
                                                                          83,
                                                                          83),
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'ที่อยู่:',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        83,
                                                                        83,
                                                                        83)),
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Container(
                                                          width: 150,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: Text(
                                                                state
                                                                    .searchResult[
                                                                        index]
                                                                    .customerAddress,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'มาตรวัดน้ำ:',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        83,
                                                                        83,
                                                                        83)),
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Container(
                                                            decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        221,
                                                                        221,
                                                                        221)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: Text(
                                                                state
                                                                    .searchResult[
                                                                        index]
                                                                    .meterNumber,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          const Text(
                                                            'เขต',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        83,
                                                                        83,
                                                                        83)),
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Container(
                                                            decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        221,
                                                                        221,
                                                                        221)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: Text(
                                                                state
                                                                    .searchResult[
                                                                        index]
                                                                    .areaNumber,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: (() {
                                                    print(state
                                                        .searchResult[index].id
                                                        .toString());

                                                    Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    250),
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        child:
                                                            Water_Unit_Detail(
                                                          id: state
                                                              .searchResult[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20, 15, 20, 15),
                                                    height: double.infinity,
                                                    decoration: const BoxDecoration(
                                                        color:
                                                            Palette.thisGreen,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/meter.png',
                                                          height: 75,
                                                          width: 75,
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        const Text(
                                                          'จด',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : InkWell(
                                  onTap: () {
                                    print('invoice id: ' +
                                        state.searchResult[index].invoiceID
                                            .toString());

                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          duration:
                                              const Duration(milliseconds: 100),
                                          type: PageTransitionType.rightToLeft,
                                          child: Invoice_Page(
                                            invoiceID: state
                                                .searchResult[index].invoiceID
                                                .toString(),
                                            ckeckWidget: 'from_list',
                                          )),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        child: Container(
                                          height: 130,
                                          width: double.maxFinite,
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: const BoxDecoration(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
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
                                                            decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        241,
                                                                        241,
                                                                        241)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: Text(
                                                                'เลข ป. ' +
                                                                    state
                                                                        .searchResult[
                                                                            index]
                                                                        .waterNumber,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        child: Text(
                                                          state
                                                              .searchResult[
                                                                  index]
                                                              .customerName
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          83,
                                                                          83,
                                                                          83),
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'ที่อยู่:',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        83,
                                                                        83,
                                                                        83)),
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Container(
                                                            width: 200,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: Text(
                                                                state
                                                                    .searchResult[
                                                                        index]
                                                                    .customerAddress
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'มาตรวัดน้ำ:',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        83,
                                                                        83,
                                                                        83)),
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Container(
                                                            decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        241,
                                                                        241,
                                                                        241)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: Text(
                                                                state
                                                                    .searchResult[
                                                                        index]
                                                                    .meterNumber
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          const Text(
                                                            'เขต',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        83,
                                                                        83,
                                                                        83)),
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Container(
                                                            decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        241,
                                                                        241,
                                                                        241)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: Text(
                                                                state
                                                                    .searchResult[
                                                                        index]
                                                                    .areaNumber
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(20),
                                                  height: double.infinity,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  241,
                                                                  241,
                                                                  241),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/done_icon.png',
                                                        height: 50,
                                                        color:
                                                            Palette.thisGreen,
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      const Text(
                                                        'ดูใบแจ้งหนี้',
                                                        style: TextStyle(
                                                            color: Palette
                                                                .thisGreen,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
