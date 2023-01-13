import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import '../ETC/color_green.dart';
import '../First_Page_bottomBar.dart';
import '../printable pages/invoice.dart';

class WriteUnit_Request {
  String? current_unit;
  String? water_meter_record_id;

  WriteUnit_Request({this.current_unit, this.water_meter_record_id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_unit'] = this.current_unit;
    data['water_meter_record_id'] = this.water_meter_record_id;

    return data;
  }
}

Future<void> write_unit(context, WriteUnit_Request write_requestModel) async {
  String urlPost = waterWork_domain + 'water_meter_record/update';

  SharedPreferences prefs2 = await SharedPreferences.getInstance();
  var getThatToken = prefs2.get('keyToken');

  var body_unitWritten = json.encode(write_requestModel.toJson());
  final response = await http.post(
    Uri.parse(urlPost),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getThatToken',
    },
    body: body_unitWritten,
  );

  var jsonRes = json.decode(response.body);
  if (response.statusCode == 200 || response.statusCode == 400) {
    print('----------- success -----------');
    print(jsonRes['data']['invoice']['id']);
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Palette.thisGreen,
                    content: Text('จดหน่วยน้ำเสร็จสิ้น'),
                  ));
      Navigator.push(
        context,
        PageTransition(
            duration: Duration(milliseconds: 100),
            type: PageTransitionType.rightToLeft,
            child: Invoice_Page(
              invoiceID: jsonRes['data']['invoice']['id'].toString(),
            )),
      );
    
  
    
    // Navigator.push(
    //   context,
    //   PageTransition(
    //     duration: Duration(milliseconds: 250),
    //     type: PageTransitionType.rightToLeft,
    //     child: Invoice_Page(),
    //   ),
    // );
  } else {
    print('----------- failed -----------');
    print(response.body);
    throw Exception(e);
  }
}
