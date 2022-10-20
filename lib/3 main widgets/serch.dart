import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/user_consume_info.dart';
import 'package:waterworks/water_unit_info.dart';

class Search_Page extends StatefulWidget {
  Search_Page({Key? key}) : super(key: key);

  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
  ];

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
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.059,
                      width: double.infinity,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'ค้นหา',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Palette.thisGreen,
                            size: 20,
                          ),
                          hintStyle: TextStyle(color: Palette.thisGreen),
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 230, 228, 228),
                                width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0),
                          ),
                        ),
                      )),
                ),
                // Container(
                //   child: Column(
                //     children: [
                //       ClipRRect(
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(16.0)),
                //         child: Container(
                //           height: 110,
                //           width: double.maxFinite,
                //           padding: const EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             border: Border(
                //               left: BorderSide(width: 10.0, color: Colors.grey),
                //             ),
                //           ),
                //           child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 8.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceAround,
                //                     children: [
                //                       Text(
                //                         '416',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.bold,
                //                             color: Colors.grey,
                //                             fontSize: 20),
                //                       ),
                //                       Text(
                //                         'คุณชวันธร วีรจรรยาพันธ์',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.bold,
                //                             color:
                //                                 Color.fromARGB(255, 83, 83, 83),
                //                             fontSize: 18),
                //                       ),
                //                       Row(
                //                         children: [
                //                           Text(
                //                             'มาตราวัดน้ำ:',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '190331',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Text(
                //                             'เลข ป.',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '01',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Text(
                //                             'เขต',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '03',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //                 Container(
                //                   width: 110,
                //                   height: double.infinity,
                //                   decoration: BoxDecoration(
                //                       color: Colors.grey,
                //                       borderRadius: BorderRadius.all(
                //                           Radius.circular(10))),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.center,
                //                     children: [
                //                       SvgPicture.asset(
                //                           'assets/images/dripping.svg'),
                //                       SizedBox(
                //                         height: 8,
                //                       ),
                //                       Text(
                //                         'จดมาตราวัดน้ำ',
                //                         style: TextStyle(
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.bold,
                //                             fontSize: 15),
                //                       )
                //                     ],
                //                   ),
                //                 )
                //               ]),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       ClipRRect(
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(16.0)),
                //         child: InkWell(
                //           onTap: () {
                //             Navigator.push(
                //               context,
                //               PageTransition(
                //                 duration: Duration(milliseconds: 250),
                //                 type: PageTransitionType.rightToLeft,
                //                 child: Use_Water_Info(),
                //               ),
                //             );
                //             ;
                //           },
                //           child: Container(
                //             height: 110,
                //             width: double.maxFinite,
                //             padding: const EdgeInsets.all(5.0),
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               border: Border(
                //                 left: BorderSide(
                //                   width: 10.0,
                //                   color: Palette.thisGreen,
                //                 ),
                //               ),
                //             ),
                //             child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(left: 8.0),
                //                     child: Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceAround,
                //                       children: [
                //                         Text(
                //                           '14/852',
                //                           style: TextStyle(
                //                               fontWeight: FontWeight.bold,
                //                               color: Color.fromARGB(
                //                                   255, 6, 148, 93),
                //                               fontSize: 20),
                //                         ),
                //                         Text(
                //                           'คุณชวันธร วีรจรรยาพันธ์',
                //                           style: TextStyle(
                //                               fontWeight: FontWeight.bold,
                //                               color: Color.fromARGB(
                //                                   255, 83, 83, 83),
                //                               fontSize: 18),
                //                         ),
                //                         Row(
                //                           children: [
                //                             Text(
                //                               'มาตราวัดน้ำ:',
                //                               style: TextStyle(
                //                                   fontSize: 13,
                //                                   fontWeight: FontWeight.bold,
                //                                   color: Color.fromARGB(
                //                                       255, 83, 83, 83)),
                //                             ),
                //                             SizedBox(
                //                               width: 3,
                //                             ),
                //                             Container(
                //                               decoration: BoxDecoration(
                //                                   borderRadius:
                //                                       BorderRadius.all(
                //                                           Radius.circular(5)),
                //                                   color: Color.fromARGB(
                //                                       255, 221, 221, 221)),
                //                               child: Padding(
                //                                 padding: EdgeInsets.only(
                //                                     left: 5, right: 5),
                //                                 child: Text(
                //                                   '12345',
                //                                   style: TextStyle(
                //                                       fontSize: 13,
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       color: Colors.black),
                //                                 ),
                //                               ),
                //                             ),
                //                             SizedBox(
                //                               width: 3,
                //                             ),
                //                             Text(
                //                               'เลข ป.',
                //                               style: TextStyle(
                //                                   fontSize: 13,
                //                                   fontWeight: FontWeight.bold,
                //                                   color: Color.fromARGB(
                //                                       255, 83, 83, 83)),
                //                             ),
                //                             SizedBox(
                //                               width: 3,
                //                             ),
                //                             Container(
                //                               decoration: BoxDecoration(
                //                                   borderRadius:
                //                                       BorderRadius.all(
                //                                           Radius.circular(5)),
                //                                   color: Color.fromARGB(
                //                                       255, 221, 221, 221)),
                //                               child: Padding(
                //                                 padding: EdgeInsets.only(
                //                                     left: 5, right: 5),
                //                                 child: Text(
                //                                   '00',
                //                                   style: TextStyle(
                //                                       fontSize: 13,
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       color: Colors.black),
                //                                 ),
                //                               ),
                //                             ),
                //                             SizedBox(
                //                               width: 3,
                //                             ),
                //                             Text(
                //                               'เขต',
                //                               style: TextStyle(
                //                                   fontSize: 13,
                //                                   fontWeight: FontWeight.bold,
                //                                   color: Color.fromARGB(
                //                                       255, 83, 83, 83)),
                //                             ),
                //                             SizedBox(
                //                               width: 3,
                //                             ),
                //                             Container(
                //                               decoration: BoxDecoration(
                //                                   borderRadius:
                //                                       BorderRadius.all(
                //                                           Radius.circular(5)),
                //                                   color: Color.fromARGB(
                //                                       255, 221, 221, 221)),
                //                               child: Padding(
                //                                 padding: EdgeInsets.only(
                //                                     left: 5, right: 5),
                //                                 child: Text(
                //                                   '00',
                //                                   style: TextStyle(
                //                                       fontSize: 13,
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       color: Colors.black),
                //                                 ),
                //                               ),
                //                             ),
                //                           ],
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                   InkWell(
                //                     onTap: (() {
                //                       Navigator.push(
                //                         context,
                //                         PageTransition(
                //                           duration: Duration(milliseconds: 250),
                //                           type: PageTransitionType.rightToLeft,
                //                           child: Water_Unit_Detail(),
                //                         ),
                //                       );
                //                     }),
                //                     child: Container(
                //                       width: 110,
                //                       height: double.infinity,
                //                       decoration: BoxDecoration(
                //                           color: Palette.thisGreen,
                //                           borderRadius: BorderRadius.all(
                //                               Radius.circular(10))),
                //                       child: Column(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.center,
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.center,
                //                         children: [
                //                           SvgPicture.asset(
                //                               'assets/images/dripping.svg'),
                //                           SizedBox(
                //                             height: 8,
                //                           ),
                //                           Text(
                //                             'จดมาตราวัดน้ำ',
                //                             style: TextStyle(
                //                                 color: Colors.white,
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 15),
                //                           )
                //                         ],
                //                       ),
                //                     ),
                //                   )
                //                 ]),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       ClipRRect(
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(16.0)),
                //         child: Container(
                //           height: 110,
                //           width: double.maxFinite,
                //           padding: const EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             border: Border(
                //               left: BorderSide(
                //                 width: 10.0,
                //                 color: Palette.thisGreen,
                //               ),
                //             ),
                //           ),
                //           child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 8.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceAround,
                //                     children: [
                //                       Text(
                //                         '217/7',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.bold,
                //                             color:
                //                                 Color.fromARGB(255, 6, 148, 93),
                //                             fontSize: 20),
                //                       ),
                //                       Text(
                //                         'คุณชวันธร วีรจรรยาพันธ์',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.bold,
                //                             color:
                //                                 Color.fromARGB(255, 83, 83, 83),
                //                             fontSize: 18),
                //                       ),
                //                       Row(
                //                         children: [
                //                           Text(
                //                             'มาตราวัดน้ำ:',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '124221',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Text(
                //                             'เลข ป.',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '00',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Text(
                //                             'เขต',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '00',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //                 Container(
                //                   width: 110,
                //                   height: double.infinity,
                //                   decoration: BoxDecoration(
                //                       color: Palette.thisGreen,
                //                       borderRadius: BorderRadius.all(
                //                           Radius.circular(10))),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.center,
                //                     children: [
                //                       SvgPicture.asset(
                //                           'assets/images/dripping.svg'),
                //                       SizedBox(
                //                         height: 8,
                //                       ),
                //                       Text(
                //                         'จดมาตราวัดน้ำ',
                //                         style: TextStyle(
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.bold,
                //                             fontSize: 15),
                //                       )
                //                     ],
                //                   ),
                //                 )
                //               ]),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       ClipRRect(
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(16.0)),
                //         child: Container(
                //           height: 110,
                //           width: double.maxFinite,
                //           padding: const EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             border: Border(
                //               left: BorderSide(
                //                 width: 10.0,
                //                 color: Palette.thisGreen,
                //               ),
                //             ),
                //           ),
                //           child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 8.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceAround,
                //                     children: [
                //                       Text(
                //                         '555/87',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.bold,
                //                             color:
                //                                 Color.fromARGB(255, 6, 148, 93),
                //                             fontSize: 20),
                //                       ),
                //                       Text(
                //                         'คุณชวันธร วีรจรรยาพันธ์',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.bold,
                //                             color:
                //                                 Color.fromARGB(255, 83, 83, 83),
                //                             fontSize: 18),
                //                       ),
                //                       Row(
                //                         children: [
                //                           Text(
                //                             'มาตราวัดน้ำ:',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '222111',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Text(
                //                             'เลข ป.',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '00',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Text(
                //                             'เขต',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '00',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //                 Container(
                //                   width: 110,
                //                   height: double.infinity,
                //                   decoration: BoxDecoration(
                //                       color: Palette.thisGreen,
                //                       borderRadius: BorderRadius.all(
                //                           Radius.circular(10))),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.center,
                //                     children: [
                //                       SvgPicture.asset(
                //                           'assets/images/dripping.svg'),
                //                       SizedBox(
                //                         height: 8,
                //                       ),
                //                       Text(
                //                         'จดมาตราวัดน้ำ',
                //                         style: TextStyle(
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.bold,
                //                             fontSize: 15),
                //                       )
                //                     ],
                //                   ),
                //                 )
                //               ]),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       ClipRRect(
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(16.0)),
                //         child: Container(
                //           height: 110,
                //           width: double.maxFinite,
                //           padding: const EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             border: Border(
                //               left: BorderSide(
                //                 width: 10.0,
                //                 color: Palette.thisGreen,
                //               ),
                //             ),
                //           ),
                //           child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 8.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceAround,
                //                     children: [
                //                       Text(
                //                         '212/224',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.bold,
                //                             color:
                //                                 Color.fromARGB(255, 6, 148, 93),
                //                             fontSize: 20),
                //                       ),
                //                       Text(
                //                         'คุณชวันธร วีรจรรยาพันธ์',
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.bold,
                //                             color:
                //                                 Color.fromARGB(255, 83, 83, 83),
                //                             fontSize: 18),
                //                       ),
                //                       Row(
                //                         children: [
                //                           Text(
                //                             'มาตราวัดน้ำ:',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '332111',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Text(
                //                             'เลข ป.',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '00',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Text(
                //                             'เขต',
                //                             style: TextStyle(
                //                                 fontSize: 13,
                //                                 fontWeight: FontWeight.bold,
                //                                 color: Color.fromARGB(
                //                                     255, 83, 83, 83)),
                //                           ),
                //                           SizedBox(
                //                             width: 3,
                //                           ),
                //                           Container(
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.all(
                //                                     Radius.circular(5)),
                //                                 color: Color.fromARGB(
                //                                     255, 221, 221, 221)),
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                   left: 5, right: 5),
                //                               child: Text(
                //                                 '00',
                //                                 style: TextStyle(
                //                                     fontSize: 13,
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Colors.black),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //                 Container(
                //                   width: 110,
                //                   height: double.infinity,
                //                   decoration: BoxDecoration(
                //                       color: Palette.thisGreen,
                //                       borderRadius: BorderRadius.all(
                //                           Radius.circular(10))),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.center,
                //                     children: [
                //                       SvgPicture.asset(
                //                           'assets/images/dripping.svg'),
                //                       SizedBox(
                //                         height: 8,
                //                       ),
                //                       Text(
                //                         'จดมาตราวัดน้ำ',
                //                         style: TextStyle(
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.bold,
                //                             fontSize: 15),
                //                       )
                //                     ],
                //                   ),
                //                 )
                //               ]),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}
