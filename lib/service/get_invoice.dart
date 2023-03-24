import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
  String? invoiceNumber;
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
  String? due_date_format;
  String? createdAt;
  String? updatedAt;
  String? customerWaterId;
  String? vat;
  String? total;
  String? discount;
  String? sumService;
  String? crossbankNumber;
  Null? userIncomeId;
  Null? incomeSegmentationId;
  Null? incomeSegmentation;
  Null? userIncome;
  Null? incomeDate;
  Null? userInvoiceId;
  Null? userInvoiceName;
  Null? userInvoiceDate;
  Null? billNo;
  int? countInvoices;
  String? sumInvoice;
  String? sumTotal;
  String? dueDateFormat;
  String? issueDateFormat;
  String? sumFormat;
  WaterMeterRecord? waterMeterRecord;

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
      this.sumInvoice,
      this.remark,
      this.issueDate,
      this.due_date_format,
      this.createdAt,
      this.updatedAt,
      this.customerWaterId,
      this.vat,
      this.total,
      this.discount,
      this.sumService,
      this.crossbankNumber,
      this.userIncomeId,
      this.incomeSegmentationId,
      this.incomeSegmentation,
      this.userIncome,
      this.incomeDate,
      this.userInvoiceId,
      this.userInvoiceName,
      this.userInvoiceDate,
      this.billNo,
      this.countInvoices,
      this.sumTotal,
      this.dueDateFormat,
      this.issueDateFormat,
      this.sumFormat,
      this.waterMeterRecord});

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
    due_date_format = json['due_date_format'];
    sumInvoice = json['sum_invoice'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerWaterId = json['customer_water_id'];
    vat = json['vat'];
    total = json['total'];
    discount = json['discount'];
    sumService = json['sum_service'];
    crossbankNumber = json['crossbank_number'];
    userIncomeId = json['user_income_id'];
    incomeSegmentationId = json['income_segmentation_id'];
    incomeSegmentation = json['income_segmentation'];
    userIncome = json['user_income'];
    incomeDate = json['income_date'];
    userInvoiceId = json['user_invoice_id'];
    userInvoiceName = json['user_invoice_name'];
    userInvoiceDate = json['user_invoice_date'];
    billNo = json['bill_no'];
    countInvoices = json['count_invoices'];
    sumTotal = json['sum_total'];
    dueDateFormat = json['due_date_format'];
    issueDateFormat = json['issue_date_format'];
    sumFormat = json['sum_format'];
    waterMeterRecord = json['water_meter_record'] != null ? new WaterMeterRecord.fromJson(json['water_meter_record']) : null;
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
    data['sum_invoice'] = this.sumInvoice;
    data['remark'] = this.remark;
    data['issue_date'] = this.issueDate;
    data['due_date_format'] = this.due_date_format;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_water_id'] = this.customerWaterId;
    data['vat'] = this.vat;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['sum_service'] = this.sumService;
    data['crossbank_number'] = this.crossbankNumber;
    data['user_income_id'] = this.userIncomeId;
    data['income_segmentation_id'] = this.incomeSegmentationId;
    data['income_segmentation'] = this.incomeSegmentation;
    data['user_income'] = this.userIncome;
    data['income_date'] = this.incomeDate;
    data['user_invoice_id'] = this.userInvoiceId;
    data['user_invoice_name'] = this.userInvoiceName;
    data['user_invoice_date'] = this.userInvoiceDate;
    data['bill_no'] = this.billNo;
    data['count_invoices'] = this.countInvoices;
    data['sum_total'] = this.sumTotal;
    data['due_date_format'] = this.dueDateFormat;
    data['issue_date_format'] = this.issueDateFormat;
    data['sum_format'] = this.sumFormat;
    if (this.waterMeterRecord != null) {
      data['water_meter_record'] = this.waterMeterRecord!.toJson();
    }
    return data;
  }
}

class WaterMeterRecord {
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
  String? previousUnit;
  String? currentUnit;
  String? sumUnit;
  String? createdAt;
  String? updatedAt;
  String? areaWaterNumber;
  String? waterWrong;
  String? record_date_format;

  WaterMeterRecord(
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
      this.waterWrong,
      this.record_date_format
      
      
      });

  WaterMeterRecord.fromJson(Map<String, dynamic> json) {
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
    waterWrong = json['water_wrong'];
    record_date_format = json['record_date_format'];
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
    data['water_wrong'] = this.waterWrong;
    data['record_date_format'] = this.record_date_format;
    return data;
  }
}

Future<Invoice_Data> fetch_invoice(String invoice_id) async {
  print('fetch_invoice');
  SharedPreferences prefs2 = await SharedPreferences.getInstance();
  var token = prefs2.get('keyToken');

  var url = waterWork_domain + 'record/invoice/' + invoice_id.toString();
  var response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  var jsonResponse = json.decode(response.body)['data'];
  // var jsonCon = jsonResponse['data'];
  // var k = jsonResponse['data']['count_invoices'];
  print(response.body);
  Invoice_Data invoice_Data = Invoice_Data.fromJson(jsonResponse);
  return invoice_Data;
}
