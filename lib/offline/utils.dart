import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waterworks/offline/office_route.dart';

Future<void> checkInternet(context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //print('connected');
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

void loadingInternet() {
  Fluttertoast.showToast(
      msg: 'กำลังเชื่อมต่อ...',
      backgroundColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.black,
      fontSize: 16.0);
}

Future<void> showMyDialog(context, tryConn) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('การเชื่อมต่อผิดพลาด'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('โปรดเชื่อมต่ออินเตอร์เน็ตและลองอีกครั้ง'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('เชื่อมต่ออีกครั้ง'),
            onPressed: tryConn,
          ),
          TextButton(
            child: const Text('บันทึกออฟไลน์'),
            onPressed: () {
              Navigator.push(context, pageOffice());
            },
          ),
        ],
      );
    },
  );
}
