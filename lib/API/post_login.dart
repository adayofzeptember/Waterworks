import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import '../First_Page_bottomBar.dart';

class Login_Request {
  String? username;
  String? password;
  String? device_name;

  Login_Request({this.username, this.password, this.device_name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['device_name'] = this.device_name;
    return data;
  }
}





// Future<Login> loginNormal(Login_Request requestModel) async {
//   String urlPost = waterWork_domain + 'login';
//   var body_Login = json.encode(requestModel.toJson());
//   final response = await http.post(
//     Uri.parse(urlPost),
//     headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
//     body: body_Login,
//   );
//   var jsonRes = json.decode(response.body);
//   if (response.statusCode == 400 || response.statusCode == 200) 
//   print(jsonDecode(response.body.toString()));
//     print(response.body);
//     return Login.fromJson(json.decode(response.body));
//   } else {
//     throw Exception("error");
//   }
// }
