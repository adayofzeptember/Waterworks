import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/bloc/load_done/done_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../offline/utils.dart';
import '../invoice_page.dart';

class Done extends StatefulWidget {
  Done({Key? key}) : super(key: key);

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  ScrollController scController = ScrollController();

  @override
  void initState() {
    check();
    context.read<DoneBloc>().add(Load_DoneData());
    scController.addListener(() {
      if (scController.position.pixels == scController.position.maxScrollExtent) {
        context.read<DoneBloc>().add(Load_DoneData());
      }
    });
    super.initState();
  }

  void check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
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
    return Scaffold(
      body: Column(
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
                    return BlocBuilder<DoneBloc, DoneState>(builder: (context, notWriteState) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: (index == notWriteState.segmentActive) ? Palette.thisGreen : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            context.read<DoneBloc>().add(FilterData(
                                  id: profileState.idSegs[index].toString(),
                                  segmentActive: index,
                                  stopLoad: true,
                                ));
                          },
                          child: Text(
                            profileState.segs[index],
                            style: TextStyle(
                              color: (index == notWriteState.segmentActive) ? Colors.white : Palette.thisGreen,
                            ),
                          ),
                        ),
                      );
                    });
                  },
                );
              },
            ),
          ),
          BlocBuilder<DoneBloc, DoneState>(builder: (context, state) {
            if (state.written.isEmpty) {
              return Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: (state.error == 'not')
                      ? const Text('ไม่มีข้อมูล')
                      : (state.segmentActive > 0)
                          ? Center(
                              child: (Platform.isAndroid) ? const CircularProgressIndicator() : const CupertinoActivityIndicator(),
                            )
                          : Container());
            } else {
              return Container();
            }
          }),
          Expanded(
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: BlocBuilder<DoneBloc, DoneState>(
                builder: (context, state) {
                  return Scrollbar(
                    thickness: 10,
                    radius: const Radius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        key: const PageStorageKey<String>('page2'),
                        controller: scController,
                        itemCount:
                            (state.isLoading == true && state.stopLoad == false) ? state.written.length + 1 : state.written.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == state.written.length && state.isLoading == true && state.stopLoad == false) {
                            return Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Center(
                                  child:
                                      (Platform.isAndroid) ? const CircularProgressIndicator() : const CupertinoActivityIndicator()),
                            );
                          }

                          return InkWell(
                            onTap: () {
                              print('invoice id: ' + state.written[index].invoiceID.toString());

                              Navigator.push(
                                context,
                                PageTransition(
                                    duration: const Duration(milliseconds: 100),
                                    type: PageTransitionType.rightToLeft,
                                    child: Invoice_Page(
                                      invoiceID: state.written[index].invoiceID.toString(),
                                      ckeckWidget: 'from_list',
                                    )),
                              );
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                                  child: Container(
                                    height: 130,
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        left: BorderSide(width: 15.0, color: Color.fromARGB(255, 233, 233, 233)),
                                      ),
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                      color: Color.fromARGB(255, 241, 241, 241)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                                    child: Text(
                                                      'เลข ป. ' + state.written[index].waterNumber,
                                                      style: const TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
                                                state.written[index].customerName.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(255, 83, 83, 83),
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
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(255, 83, 83, 83)),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  width: 200,
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                                    child: Text(
                                                      state.written[index].customerAddress.toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
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
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(255, 83, 83, 83)),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                      color: Color.fromARGB(255, 241, 241, 241)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                                    child: Text(
                                                      state.written[index].meterNumber.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
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
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(255, 83, 83, 83)),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                      color: Color.fromARGB(255, 241, 241, 241)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                                    child: Text(
                                                      state.written[index].areaNumber.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        height: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(255, 241, 241, 241),
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/done_icon.png',
                                              height: 50,
                                              color: Palette.thisGreen,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text(
                                              'ดูใบแจ้งหนี้',
                                              style: TextStyle(color: Palette.thisGreen, fontWeight: FontWeight.bold, fontSize: 14),
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
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
