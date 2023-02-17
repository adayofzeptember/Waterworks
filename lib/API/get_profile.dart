import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:waterworks/ETC/api_domain_url.dart';

class Profile {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  String? sessionID;
  int? serverDateTimeMS;
  String? serverDatetime;
  Profile_Data? data;

  Profile(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.sessionID,
      this.serverDateTimeMS,
      this.serverDatetime,
      this.data});

  Profile.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    sessionID = json['sessionID'];
    serverDateTimeMS = json['serverDateTimeMS'];
    serverDatetime = json['serverDatetime'];
    data =
        json['data'] != null ? new Profile_Data.fromJson(json['data']) : null;
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

class Profile_Data {
  int? id;
  String? username;
  String? name;
  String? email;
  String? active;
  String? positionId;
  String? createdAt;
  String? updatedAt;
  List<Segmentations>? segmentations;

  Profile_Data(
      {this.id,
      this.username,
      this.name,
      this.email,
      this.active,
      this.positionId,
      this.createdAt,
      this.updatedAt,
      this.segmentations});

  Profile_Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    active = json['active'];
    positionId = json['position_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['segmentations'] != null) {
      segmentations = <Segmentations>[];
      json['segmentations'].forEach((v) {
        segmentations!.add(new Segmentations.fromJson(v));
      });
    }
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
    if (this.segmentations != null) {
      data['segmentations'] =
          this.segmentations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Segmentations {
  int? id;
  String? name;
  String? userId;
  String? assignDate;
  String? status;
  String? remark;
  String? createdAt;
  String? updatedAt;

  Segmentations(
      {this.id,
      this.name,
      this.userId,
      this.assignDate,
      this.status,
      this.remark,
      this.createdAt,
      this.updatedAt});

  Segmentations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    assignDate = json['assign_date'];
    status = json['status'];
    remark = json['remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['assign_date'] = this.assignDate;
    data['status'] = this.status;
    data['remark'] = this.remark;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

Future<Profile_Data> fetchProfile_Auth(String token) async {
  var url = waterWork_domain + 'me';
  var response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  var jsonResponse = json.decode(response.body);
  var jsonCon = jsonResponse['data'];
  var k = jsonResponse['data']['id'];
  Profile_Data user_profileData = Profile_Data.fromJson(jsonCon);

  return user_profileData;
}
