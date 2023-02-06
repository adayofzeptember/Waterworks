import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:waterworks/ETC/api_domain_url.dart';
//! โมเดล json

class Personal_Use {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  String? sessionID;
  int? serverDateTimeMS;
  String? serverDatetime;
  User_Consume_Data? data;

  Personal_Use(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.sessionID,
      this.serverDateTimeMS,
      this.serverDatetime,
      this.data});

  Personal_Use.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    sessionID = json['sessionID'];
    serverDateTimeMS = json['serverDateTimeMS'];
    serverDatetime = json['serverDatetime'];
    data = json['data'] != null
        ? new User_Consume_Data.fromJson(json['data'])
        : null;
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

class User_Consume_Data {
  int? id;
  String? customerWaterId;
  String? userId;
  String? waterMeterSegmentationId;
  String? userName;
  String? waterMeterSegmentation;
  String? waterNumber;
  String? areaNumber;
  String? status;
  String? respDate;
  String? recordDate;
  int? previousUnit;
  String? currentUnit;
  String? sumUnit;
  String? createdAt;
  String? updatedAt;
  String? areaWaterNumber;
  CustomerWater? customerWater;

  User_Consume_Data(
      {this.id,
      this.customerWaterId,
      this.userId,
      this.waterMeterSegmentationId,
      this.userName,
      this.waterMeterSegmentation,
      this.waterNumber,
      this.areaNumber,
      this.status,
      this.respDate,
      this.recordDate,
      this.previousUnit,
      this.currentUnit,
      this.sumUnit,
      this.createdAt,
      this.updatedAt,
      this.areaWaterNumber,
      this.customerWater});

  User_Consume_Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerWaterId = json['customer_water_id'];
    userId = json['user_id'];
    waterMeterSegmentationId = json['water_meter_segmentation_id'];
    userName = json['user_name'];
    waterMeterSegmentation = json['water_meter_segmentation'];
    waterNumber = json['water_number'];
    areaNumber = json['area_number'];
    status = json['status'];
    respDate = json['resp_date'];
    recordDate = json['record_date'];
    previousUnit = json['previous_unit'];
    currentUnit = json['current_unit'];
    sumUnit = json['sum_unit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    areaWaterNumber = json['area_water_number'];
    customerWater = json['customer_water'] != null
        ? new CustomerWater.fromJson(json['customer_water'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_water_id'] = this.customerWaterId;
    data['user_id'] = this.userId;
    data['water_meter_segmentation_id'] = this.waterMeterSegmentationId;
    data['user_name'] = this.userName;
    data['water_meter_segmentation'] = this.waterMeterSegmentation;
    data['water_number'] = this.waterNumber;
    data['area_number'] = this.areaNumber;
    data['status'] = this.status;
    data['resp_date'] = this.respDate;
    data['record_date'] = this.recordDate;
    data['previous_unit'] = this.previousUnit;
    data['current_unit'] = this.currentUnit;
    data['sum_unit'] = this.sumUnit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['area_water_number'] = this.areaWaterNumber;
    if (this.customerWater != null) {
      data['customer_water'] = this.customerWater!.toJson();
    }
    return data;
  }
}

class CustomerWater {
  int? id;
  String? name;
  String? customerId;
  String? petitionId;
  String? waterNumber;
  String? areaNumber;
  String? meterNumber;
  String? address;
  String? subDistrict;
  String? district;
  String? province;
  String? zipcode;
  String? status;
  String? installationType;
  String? remark;
  String? createdAt;
  String? updatedAt;
  String? segmentationId;
  String? waterMeterFeeId;
  String? meterBrandName;
  String? typeId;
  String? condition;
  String? formatSegmentation;
  String? fullAddress;

  CustomerWater({
    this.id,
    this.customerId,
    this.petitionId,
    this.waterNumber,
    this.areaNumber,
    this.meterNumber,
    this.address,
    this.name,
    this.subDistrict,
    this.district,
    this.province,
    this.zipcode,
    this.status,
    this.installationType,
    this.remark,

    this.createdAt,
    this.updatedAt,
    this.segmentationId,
    this.waterMeterFeeId,
    this.meterBrandName,
    this.typeId,
    this.condition,
    this.formatSegmentation,
    this.fullAddress,
  });

  CustomerWater.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    customerId = json['customer_id'];
    petitionId = json['petition_id'];
    waterNumber = json['water_number'];
    areaNumber = json['area_number'];
    meterNumber = json['meter_number'];
    address = json['address'];
    subDistrict = json['sub_district'];
    district = json['district'];
    province = json['province'];
      
    zipcode = json['zipcode'];
    status = json['status'];
    installationType = json['installation_type'];
    remark = json['remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    segmentationId = json['segmentation_id'];
    waterMeterFeeId = json['water_meter_fee_id'];
    meterBrandName = json['meter_brand_name'];
    typeId = json['type_id'];
    condition = json['condition'];
    formatSegmentation = json['format_segmentation'];
    fullAddress = json['full_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['petition_id'] = this.petitionId;
    data['water_number'] = this.waterNumber;
    data['area_number'] = this.areaNumber;

    data['address'] = this.address;
    data['name'] = this.name;
    data['sub_district'] = this.subDistrict;
    data['district'] = this.district;
    data['province'] = this.province;
    data['zipcode'] = this.zipcode;
    data['status'] = this.status;
    data['installation_type'] = this.installationType;
    data['remark'] = this.remark;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['segmentation_id'] = this.segmentationId;
    data['water_meter_fee_id'] = this.waterMeterFeeId;
    data['meter_brand_name'] = this.meterBrandName;
    data['type_id'] = this.typeId;
    data['condition'] = this.condition;
    data['format_segmentation'] = this.formatSegmentation;
    data['full_address'] = this.fullAddress;

    return data;
  }
}

Future<User_Consume_Data> fetch_user_consume(String recordID) async {
  SharedPreferences prefs2 = await SharedPreferences.getInstance();
  var getThatToken = prefs2.get('keyToken');
  //var getThatToken = '283|yw3Wmw8dM3tyJsfaX5T5qWeFsNRJyOt5AV9ESxqO';
  var url = waterWork_domain + 'water_meter_record/show/' + recordID;
  var response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $getThatToken',
  });
  var jsonResponse = json.decode(response.body);
  var jsonCon = jsonResponse['data'];
  var k = jsonResponse['data']['customer_water']['name'];
  User_Consume_Data water_user_use = User_Consume_Data.fromJson(jsonCon);

  // print(k);

  return water_user_use;
}

void main(List<String> args) {
  fetch_user_consume('1171730');
}
