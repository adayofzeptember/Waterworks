import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:waterworks/ETC/api_domain_url.dart';



class Invoice_Record {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  String? sessionID;
  int? serverDateTimeMS;
  String? serverDatetime;
  Invoice_Data? data;

  Invoice_Record(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.sessionID,
      this.serverDateTimeMS,
      this.serverDatetime,
      this.data});

  Invoice_Record.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    sessionID = json['sessionID'];
    serverDateTimeMS = json['serverDateTimeMS'];
    serverDatetime = json['serverDatetime'];
    data = json['data'] != null ? new Invoice_Data.fromJson(json['data']) : null;
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

class Invoice_Data {
  int? id;
  Null? invoiceNumber;
  String? waterMeterRecordId;
  String? userId;
  Null? paymentType;
  String? userName;
  String? customerAddress;
  String? customerName;
  String? areaNumber;
  String? waterNumber;
  String? sum;
  String? status;
  Null? remark;
  String? issueDate;
  String? dueDate;
  String? createdAt;
  String? updatedAt;
  String? customerWaterId;
  String? dueDateFormat;
  String? issueDateFormat;
  String? sumFormat;

  Invoice_Data(
      {this.id,
      this.invoiceNumber,
      this.waterMeterRecordId,
      this.userId,
      this.paymentType,
      this.userName,
      this.customerAddress,
      this.customerName,
      this.areaNumber,
      this.waterNumber,
      this.sum,
      this.status,
      this.remark,
      this.issueDate,
      this.dueDate,
      this.createdAt,
      this.updatedAt,
      this.customerWaterId,
      this.dueDateFormat,
      this.issueDateFormat,
      this.sumFormat});

  Invoice_Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    waterMeterRecordId = json['water_meter_record_id'];
    userId = json['user_id'];
    paymentType = json['payment_type'];
    userName = json['user_name'];
    customerAddress = json['customer_address'];
    customerName = json['customer_name'];
    areaNumber = json['area_number'];
    waterNumber = json['water_number'];
    sum = json['sum'];
    status = json['status'];
    remark = json['remark'];
    issueDate = json['issue_date'];
    dueDate = json['due_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerWaterId = json['customer_water_id'];
    dueDateFormat = json['due_date_format'];
    issueDateFormat = json['issue_date_format'];
    sumFormat = json['sum_format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_number'] = this.invoiceNumber;
    data['water_meter_record_id'] = this.waterMeterRecordId;
    data['user_id'] = this.userId;
    data['payment_type'] = this.paymentType;
    data['user_name'] = this.userName;
    data['customer_address'] = this.customerAddress;
    data['customer_name'] = this.customerName;
    data['area_number'] = this.areaNumber;
    data['water_number'] = this.waterNumber;
    data['sum'] = this.sum;
    data['status'] = this.status;
    data['remark'] = this.remark;
    data['issue_date'] = this.issueDate;
    data['due_date'] = this.dueDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_water_id'] = this.customerWaterId;
    data['due_date_format'] = this.dueDateFormat;
    data['issue_date_format'] = this.issueDateFormat;
    data['sum_format'] = this.sumFormat;
    return data;
  }
}


Future<Invoice_Data> fetch_invoice(String token, String invoice_id) async {
  var url = waterWork_domain + 'record/invoice/'+invoice_id.toString();
  var response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  var jsonResponse = json.decode(response.body);
  var jsonCon = jsonResponse['data'];
  var k = jsonResponse['data']['customer_name'];
  Invoice_Data invoice_Data = Invoice_Data.fromJson(jsonCon);
   //print(k);
  // print(response.body);

  return invoice_Data;
}

