import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/bloc/write_page/write_page_bloc.dart';
import '../../bloc/load_undone/undone_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../user_consume_info.dart';

class Notyet extends StatefulWidget {
  const Notyet({Key? key}) : super(key: key);

  @override
  State<Notyet> createState() => _NotyetState();
}

class _NotyetState extends State<Notyet> {
  ScrollController scController = ScrollController();
  @override
  
  void initState() {
    context.read<NotWriteBloc>().add(Load_unDoneData());
    super.initState();
    scController.addListener(() {
      if (scController.position.pixels ==
          scController.position.maxScrollExtent) {
        context.read<NotWriteBloc>().add(Load_unDoneData());
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    scController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotWriteBloc, NotWriteState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                height: 65,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, profileState) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: profileState.segs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: (index == state.segmentActive)
                                  ? Palette.thisGreen
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              context.read<NotWriteBloc>().add(FilterData(
                                    id: profileState.idSegs[index].toString(),
                                    segmentActive: index,
                                    // stopLoad: true,
                                  ));
                            },
                            child: Text(
                              profileState.segs[index],
                              style: TextStyle(
                                color: (index == state.segmentActive)
                                    ? Colors.white
                                    : Palette.thisGreen,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              (state.notWrite.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: (state.error == 'not')
                          ? const Text('ไม่มีข้อมูล')
                          : Container())
                  : Container(),
              Expanded(
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0,
                  ),
                  child: Scrollbar(
                    thickness: 10,
                    radius: const Radius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        cacheExtent: 1000,
                        key: const PageStorageKey<String>('page'),
                        controller: scController,
                        itemCount: (state.isLoading == true &&
                                state.dataTotal != state.notWrite.length)
                            ? state.notWrite.length + 1
                            : state.notWrite.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == state.notWrite.length &&
                              state.dataTotal != state.notWrite.length) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                  child: (Platform.isAndroid)
                                      ? const CircularProgressIndicator()
                                      : const CupertinoActivityIndicator()),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              padding: const EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Palette.thisGreen,
                              ),
                              child: InkWell(
                                onTap: () {
                                  print("id: " +
                                      state.notWrite[index].id.toString());
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      type: PageTransitionType.rightToLeft,
                                      child: Use_Water_Info(
                                        id: state.notWrite[index].id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                    color: Colors.white,
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
                                                  Text(
                                                    'เลข ป. ' +
                                                        state.notWrite[index]
                                                            .waterNumber,
                                                    style: const TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 240, 41, 27)),
                                                  ),
                                                  (state.notWrite[index]
                                                              .status !=
                                                          true)
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius
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
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 5,
                                                                        right:
                                                                            5),
                                                                child: Row(
                                                                  children: const [
                                                                    Text(
                                                                      'ตัดมาตร',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .close,
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
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  state.notWrite[index]
                                                      .customerName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 83, 83, 83),
                                                      fontSize: 18),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'ที่อยู่:',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 83, 83, 83)),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  SizedBox(
                                                    width: 150,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      child: Text(
                                                        state.notWrite[index]
                                                                .customerAddress ??
                                                            '',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'มาตรวัดน้ำ:',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 83, 83, 83)),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            5)),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    221,
                                                                    221,
                                                                    221)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      child: Text(
                                                        state.notWrite[index]
                                                                .meterNumber ??
                                                            '',
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    'เขต',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 83, 83, 83)),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            5)),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    221,
                                                                    221,
                                                                    221)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      child: Text(
                                                        state.notWrite[index]
                                                                .areaNumber ??
                                                            '',
                                                        style: const TextStyle(
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
                                              const SizedBox(height: 5)
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (() {
                                            print("id: " +
                                                state.notWrite[index].id
                                                    .toString());
                                            context
                                                .read<WritePageBloc>()
                                                .add(ToPageWrite(
                                                  context: context,
                                                  id: "${state.notWrite[index].id}",
                                                ));
                                          }),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                            height: double.infinity,
                                            decoration: const BoxDecoration(
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
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Text(
                                                  'จด',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'จำนวนข้อมูล ${state.notWrite.length}/${state.dataTotal}',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
