import 'dart:async';
import 'dart:convert';
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
  String? name;
  List<Segmentations>? segmentations;

  Profile_Data({this.name, this.segmentations});


  Profile_Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    if (json['segmentations'] != null) {
      segmentations = <Segmentations>[];
      json['segmentations'].forEach((v) {
        segmentations!.add(new Segmentations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;

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


  Segmentations(
      {this.id,
      this.name,

      
      });

  Segmentations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

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

  var jsonResponse = json.decode(response.body)['data'];

  Profile_Data user_profileData = Profile_Data.fromJson(jsonResponse);

  return user_profileData;
}
