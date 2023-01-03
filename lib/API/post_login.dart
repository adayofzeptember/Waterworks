import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:waterworks/ETC/api_domain_url.dart';

class Login {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  String? sessionID;
  int? serverDateTimeMS;
  String? serverDatetime;
  Login_Response? data;

  Login(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.sessionID,
      this.serverDateTimeMS,
      this.serverDatetime,
      this.data});

  Login.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    sessionID = json['sessionID'];
    serverDateTimeMS = json['serverDateTimeMS'];
    serverDatetime = json['serverDatetime'];
    data =
        json['data'] != null ? new Login_Response.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseStatus'] = this.responseStatus;
    data['responseMessage'] = this.responseMessage;
    data['sessionID'] = this.sessionID;
    data['serverDateTimeMS'] = this.serverDateTimeMS;
    data['serverDatetime'] = this.serverDatetime;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Login_Response {
  User_Data? data_user;
  String? accessToken;
  String? tokenType;

  Login_Response({this.data_user, this.accessToken, this.tokenType});

  Login_Response.fromJson(Map<String, dynamic> json) {
    data_user =
        json['user'] != null ? new User_Data.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data_user != null) {
      data['user'] = this.data_user!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class User_Data {
  int? id;
  String? username;
  String? name;
  String? email;
  String? active;
  Null? positionId;
  Null? createdAt;
  Null? updatedAt;

  User_Data(
      {this.id,
      this.username,
      this.name,
      this.email,
      this.active,
      this.positionId,
      this.createdAt,
      this.updatedAt});

  User_Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    active = json['active'];
    positionId = json['position_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['active'] = this.active;
    data['position_id'] = this.positionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

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
//   if (response.statusCode == 400 || response.statusCode == 200) {
//     //print(jsonDecode(response.body.toString()));
//     print(response.body);
//     return Login.fromJson(json.decode(response.body));
//   } else {
//     throw Exception("error");
//   }
// }
