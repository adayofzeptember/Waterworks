import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import '../ETC/color_green.dart';
import '../ETC/shapes_painter.dart';
import '../bloc/load_done/done_bloc.dart';
import '../bloc/load_undone/undone_bloc.dart';
import '../bloc/search/search_bloc.dart';
import '../bloc/write_page/write_page_bloc.dart';
import '../offline/utils.dart';

class WritePage extends StatelessWidget {
  String? check;
  bool butt = true;
  WritePage({Key? key, this.check}) : super(key: key);
  TextEditingController waterUnitController = TextEditingController();

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Palette.thisGreen,
          centerTitle: true,
          title: const Text('จดมาตรวัดน้ำ'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<WritePageBloc>().add(ClearRadioDefault());
              context.read<WritePageBloc>().add(EnabledButton(getButt: true));
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          )),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: BlocBuilder<WritePageBloc, WritePageState>(
          builder: (context, state) {
            if (state.loading == true) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    CustomPaint(
                      painter: ShapesPainter(),
                      child: Container(height: 150),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 245, 245, 245),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  state.customerName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'บ้านเลขที่ ' + state.address,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 83, 83, 83)),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'มาตรวัดน้ำ:',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 83, 83, 83)),
                                    ),
                                    const SizedBox(width: 3),
                                    Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Color.fromARGB(
                                              255, 221, 221, 221)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Text(
                                          state.meterNumber,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'เลข ป:',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 83, 83, 83)),
                                    ),
                                    const SizedBox(width: 3),
                                    Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Color.fromARGB(
                                              255, 221, 221, 221)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Text(
                                          state.waterNumber,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'เขต:',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 83, 83, 83)),
                                    ),
                                    const SizedBox(width: 3),
                                    Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Color.fromARGB(
                                              255, 221, 221, 221)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Text(
                                          state.areaNumber,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'เลขมาตรวัดน้ำที่แล้ว: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                              Text(
                                state.previousUnitFormat,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: waterUnitController,
                            autofocus: false,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: (state.checkCurrentUnit)
                                  ? '*กรอกมาตรวัดน้ำปัจจุบัน'
                                  : 'กรอกมาตรวัดน้ำปัจจุบัน',
                              hintStyle: TextStyle(
                                  color: (state.checkCurrentUnit)
                                      ? Colors.red
                                      : Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: (state.checkCurrentUnit)
                                          ? Colors.red
                                          : Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: (state.checkCurrentUnit)
                                          ? Colors.red
                                          : Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 238, 238, 238),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'เลือกสถานะมาตร : ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    state.writeCondition,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: state.writeCondition == "ปกติ"
                                            ? Palette.thisGreen
                                            : Colors.red),
                                  ),
                                ],
                              ),
                              RadioGroup<String>.builder(
                                textStyle: const TextStyle(fontSize: 20),
                                groupValue: state.writeCondition,
                                onChanged: (value) {
                                  context.read<WritePageBloc>().add(
                                      CheckThisBro(
                                          getCondiotionRadio:
                                              value.toString()));
                                },
                                items: const [
                                  "ปกติ",
                                  "รอบใหม่",
                                  "มาตรใหม่",
                                  "มาตรชำรุด"
                                ],
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item,
                                ),
                                fillColor: Palette.thisGreen,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Palette.thisGreen,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                onPressed: () {
                                  context
                                      .read<WritePageBloc>()
                                      .add(CheckCurrentUnit(
                                        currentUnit: waterUnitController.text,
                                      ));
                                  if (waterUnitController.text != "") {
                                    if (state.writeCondition == "ปกติ") {
                                      if (int.parse(state.previousUnitFormat) >
                                          int.parse(waterUnitController.text)) {
                                        showAlertWriteERROR(context);
                                      } else {
                                        showAlertWriteOK(
                                          context,
                                          waterUnitController.text,
                                          'ปกติ',
                                          '0',
                                          state.writeRecordId,
                                        );
                                      }
                                    } else if (state.writeCondition ==
                                        "รอบใหม่") {
                                      showAlertWriteOK(
                                        context,
                                        waterUnitController.text,
                                        'รอบใหม่',
                                        '1',
                                        state.writeRecordId,
                                      );
                                    } else if (state.writeCondition ==
                                        "มาตรใหม่") {
                                      showAlertWriteOK(
                                        context,
                                        waterUnitController.text,
                                        'มาตรใหม่',
                                        '2',
                                        state.writeRecordId,
                                      );
                                    } else {
                                      showAlertWriteOK(
                                        context,
                                        waterUnitController.text,
                                        'มาตรชำรุด',
                                        '3',
                                        state.writeRecordId,
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(20),
                                  child: const Text(
                                    "ยืนยัน",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Future showAlertWriteERROR(var context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      return BlocBuilder<WritePageBloc, WritePageState>(
        builder: (context, state) {
          return AlertDialog(
            title: const Text('ไม่สามารถจดหน่วยน้ำได้ !',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "เลขมาตรวัดน้ำปัจจุบันน้อยกว่าครั้งก่อน",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('โปรดตรวจสอบและจดใหม่อีกครั้ง')
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    'เข้าใจแล้ว, ต่อไปฉันจะดูให้ดี',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  context
                      .read<WritePageBloc>()
                      .add(EnabledButton(getButt: true));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> showAlertWriteOK(
  var context,
  String newUnit,
  String newStatus,
  String statusMeter,
  String writeRecordId,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      return BlocBuilder<WritePageBloc, WritePageState>(
        builder: (context, state) {
          return AlertDialog(
            title: const Text('โปรดตรวจสอบความถูกต้อง'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "เลขมาตรวัดน้ำ: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            newUnit,
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                   
                      Row(
                        children: [
                              Text(
                        
                        'สถานะ: ',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                          Text(
                            newStatus,
                            style: const TextStyle(
                                fontSize: 15, ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  context
                      .read<WritePageBloc>()
                      .add(EnabledButton(getButt: true));
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('ยืนยัน'),
                onPressed: state.buttonEnable
                    ? () async {
                        context
                            .read<WritePageBloc>()
                            .add(EnabledButton(getButt: false));

                        try {
                          final result =
                              await InternetAddress.lookup('google.com');
                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {
                            context.read<WritePageBloc>().add(ConfirmWriteUnit(
                                  context: context,
                                  statusMeter: statusMeter,
                                  currentUnit: newUnit,
                                  id: writeRecordId,
                                ));
                            context.read<NotWriteBloc>().add(BackMenu());
                            context.read<NotWriteBloc>().add(Reload_Undone());
                            context.read<DoneBloc>().add(Reload_Done());

                            context.read<SearchBloc>().add(ClearSearch());
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
                    : null,
              ),
            ],
          );
        },
      );
    },
  );
}
