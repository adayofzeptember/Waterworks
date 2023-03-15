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
  String? previousUnit;
  String? currentUnit;
  String? sumUnit;
  String? createdAt;
  String? updatedAt;
  String? areaWaterNumber;
  String? previous_unit_format;
  CustomerWater? customerWater;
  List<HistoryWaters>? historyWaters;
  List<HistoryInvoices>? historyInvoices;

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
      this.historyWaters,
      this.historyInvoices,
      this.updatedAt,
      this.previous_unit_format,
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
    previous_unit_format = json['previous_unit_format'];
    areaWaterNumber = json['area_water_number'];
    customerWater = json['customer_water'] != null
        ? new CustomerWater.fromJson(json['customer_water'])
        : null;

    if (json['history_waters'] != null) {
      historyWaters = <HistoryWaters>[];
      json['history_waters'].forEach((v) {
        historyWaters!.add(new HistoryWaters.fromJson(v));
      });
    }
    if (json['history_invoices'] != null) {
      historyInvoices = <HistoryInvoices>[];
      json['history_invoices'].forEach((v) {
        historyInvoices!.add(new HistoryInvoices.fromJson(v));
      });
    }
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
    data['previous_unit_format'] = this.previous_unit_format;
    data['area_water_number'] = this.areaWaterNumber;
    if (this.customerWater != null) {
      data['customer_water'] = this.customerWater!.toJson();
    }
    if (this.historyWaters != null) {
      data['history_waters'] =
          this.historyWaters!.map((v) => v.toJson()).toList();
    }
    if (this.historyInvoices != null) {
      data['history_invoices'] =
          this.historyInvoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryInvoices {
  int? id;
  String? invoiceNumber;
  String? waterMeterRecordId;
  String? userId;
  String? paymentType;
  String? userName;
  String? customerAddress;
  String? customerName;
  String? areaNumber;
  String? waterNumber;
  String? sum;
  String? status;
  String? remark;
  String? issueDate;
  String? dueDate;
  String? createdAt;
  String? updatedAt;
  String? customerWaterId;
  String? vat;
  String? total;
  String? discount;
  String? sumService;
  String? crossbankNumber;
  String? userIncomeId;
  String? incomeSegmentationId;
  String? incomeSegmentation;
  String? userIncome;
  String? incomeDate;
  String? userInvoiceId;
  String? userInvoiceName;
  String? userInvoiceDate;
  String? billNo;
  String? dueDateFormat;
  String? issueDateFormat;
  String? sumFormat;

  HistoryInvoices(
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
      this.dueDateFormat,
      this.issueDateFormat,
      this.sumFormat});

  HistoryInvoices.fromJson(Map<String, dynamic> json) {
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
    data['due_date_format'] = this.dueDateFormat;
    data['issue_date_format'] = this.issueDateFormat;
    data['sum_format'] = this.sumFormat;
    return data;
  }
}

class HistoryWaters {
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

  HistoryWaters(
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
      this.waterWrong});

  HistoryWaters.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class CustomerWater {
  int? id;
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
  String? incomeSegmentationId;
  String? bankPaymentAuto;
  String? bankAccount;
  String? name;
  String? statusDebtor;
  String? statusDiscount;
  String? road;
  String? latitude;
  String? longitude;
  String? installationDate;
  String? manufactureDate;
  String? segmentationOrder;
  String? formatSegmentation;
  String? fullAddress;
  Segmentation? segmentation;

  CustomerWater(
      {this.id,
      this.customerId,
      this.petitionId,
      this.waterNumber,
      this.areaNumber,
      this.meterNumber,
      this.address,
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
      this.incomeSegmentationId,
      this.bankPaymentAuto,
      this.bankAccount,
      this.name,
      this.statusDebtor,
      this.statusDiscount,
      this.road,
      this.latitude,
      this.longitude,
      this.installationDate,
      this.manufactureDate,
      this.segmentationOrder,
      this.formatSegmentation,
      this.fullAddress,
      this.segmentation});

  CustomerWater.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    incomeSegmentationId = json['income_segmentation_id'];
    bankPaymentAuto = json['bank_payment_auto'];
    bankAccount = json['bank_account'];
    name = json['name'];
    statusDebtor = json['status_debtor'];
    statusDiscount = json['status_discount'];
    road = json['road'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    installationDate = json['installation_date'];
    manufactureDate = json['manufacture_date'];
    segmentationOrder = json['segmentation_order'];
    formatSegmentation = json['format_segmentation'];
    fullAddress = json['full_address'];
    segmentation = json['segmentation'] != null
        ? new Segmentation.fromJson(json['segmentation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['petition_id'] = this.petitionId;
    data['water_number'] = this.waterNumber;
    data['area_number'] = this.areaNumber;
    data['meter_number'] = this.meterNumber;
    data['address'] = this.address;
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
    data['income_segmentation_id'] = this.incomeSegmentationId;
    data['bank_payment_auto'] = this.bankPaymentAuto;
    data['bank_account'] = this.bankAccount;
    data['name'] = this.name;
    data['status_debtor'] = this.statusDebtor;
    data['status_discount'] = this.statusDiscount;
    data['road'] = this.road;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['installation_date'] = this.installationDate;
    data['manufacture_date'] = this.manufactureDate;
    data['segmentation_order'] = this.segmentationOrder;
    data['format_segmentation'] = this.formatSegmentation;
    data['full_address'] = this.fullAddress;
    if (this.segmentation != null) {
      data['segmentation'] = this.segmentation!.toJson();
    }
    return data;
  }
}

class Segmentation {
  int? id;
  String? name;
  String? userId;
  String? assignDate;
  String? status;
  String? remark;
  String? createdAt;
  String? updatedAt;

  Segmentation(
      {this.id,
      this.name,
      this.userId,
      this.assignDate,
      this.status,
      this.remark,
      this.createdAt,
      this.updatedAt});

  Segmentation.fromJson(Map<String, dynamic> json) {
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

Future<User_Consume_Data> fetch_user_consume(String recordID) async {
  SharedPreferences prefs2 = await SharedPreferences.getInstance();
  var getThatToken = prefs2.get('keyToken');

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
  if (response.statusCode == 200) {
    //   print(response.body);
  } else {
    //print(response.body);
  }

  return water_user_use;
}
