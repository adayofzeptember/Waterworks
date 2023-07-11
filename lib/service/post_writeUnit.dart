
class Data_writeUnit {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  String? sessionID;
  int? serverDateTimeMS;
  String? serverDatetime;
  Data? data;

  Data_writeUnit(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.sessionID,
      this.serverDateTimeMS,
      this.serverDatetime,
      this.data});

  Data_writeUnit.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    sessionID = json['sessionID'];
    serverDateTimeMS = json['serverDateTimeMS'];
    serverDatetime = json['serverDatetime'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  Record? record;
  Invoice? invoice;

  Data({this.record, this.invoice});

  Data.fromJson(Map<String, dynamic> json) {
    record =
        json['record'] != null ? new Record.fromJson(json['record']) : null;
    invoice =
        json['invoice'] != null ? new Invoice.fromJson(json['invoice']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.record != null) {
      data['record'] = this.record!.toJson();
    }
    if (this.invoice != null) {
      data['invoice'] = this.invoice!.toJson();
    }
    return data;
  }
}

class Record {
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
  int? sumUnit;
  String? createdAt;
  String? updatedAt;
  String? areaWaterNumber;
  CustomerWater? customerWater;

  Record(
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

  Record.fromJson(Map<String, dynamic> json) {
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
  WaterMeterFee? waterMeterFee;
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
      this.waterMeterFee,
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
    waterMeterFee = json['water_meter_fee'] != null
        ? new WaterMeterFee.fromJson(json['water_meter_fee'])
        : null;
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
    if (this.waterMeterFee != null) {
      data['water_meter_fee'] = this.waterMeterFee!.toJson();
    }
    if (this.segmentation != null) {
      data['segmentation'] = this.segmentation!.toJson();
    }
    return data;
  }
}

class WaterMeterFee {
  int? id;
  String? name;
  String? fee;
  String? status;
  String? createdAt;
  String? updatedAt;

  WaterMeterFee(
      {this.id,
      this.name,
      this.fee,
      this.status,
      this.createdAt,
      this.updatedAt});

  WaterMeterFee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fee = json['fee'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fee'] = this.fee;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

class Invoice {
  int? waterMeterRecordId;
  int? userId;
  String? userName;
  String? customerAddress;
  String? customerName;
  int? customerWaterId;
  String? areaNumber;
  String? waterNumber;
  int? sum;
  double? vat;
  int? discount;
  String? sumService;
  double? total;
  String? status;
  String? issueDate;
  String? dueDate;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? dueDateFormat;
  String? issueDateFormat;
  String? sumFormat;

  Invoice(
      {this.waterMeterRecordId,
      this.userId,
      this.userName,
      this.customerAddress,
      this.customerName,
      this.customerWaterId,
      this.areaNumber,
      this.waterNumber,
      this.sum,
      this.vat,
      this.discount,
      this.sumService,
      this.total,
      this.status,
      this.issueDate,
      this.dueDate,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.dueDateFormat,
      this.issueDateFormat,
      this.sumFormat});

  Invoice.fromJson(Map<String, dynamic> json) {
    waterMeterRecordId = json['water_meter_record_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    customerAddress = json['customer_address'];
    customerName = json['customer_name'];
    customerWaterId = json['customer_water_id'];
    areaNumber = json['area_number'];
    waterNumber = json['water_number'];
    sum = json['sum'];
    vat = json['vat'];
    discount = json['discount'];
    sumService = json['sum_service'];
    total = json['total'];
    status = json['status'];
    issueDate = json['issue_date'];
    dueDate = json['due_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    dueDateFormat = json['due_date_format'];
    issueDateFormat = json['issue_date_format'];
    sumFormat = json['sum_format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['water_meter_record_id'] = this.waterMeterRecordId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['customer_address'] = this.customerAddress;
    data['customer_name'] = this.customerName;
    data['customer_water_id'] = this.customerWaterId;
    data['area_number'] = this.areaNumber;
    data['water_number'] = this.waterNumber;
    data['sum'] = this.sum;
    data['vat'] = this.vat;
    data['discount'] = this.discount;
    data['sum_service'] = this.sumService;
    data['total'] = this.total;
    data['status'] = this.status;
    data['issue_date'] = this.issueDate;
    data['due_date'] = this.dueDate;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['due_date_format'] = this.dueDateFormat;
    data['issue_date_format'] = this.issueDateFormat;
    data['sum_format'] = this.sumFormat;
    return data;
  }
}

class WriteUnit_Request {
  String? current_unit;
  String? water_meter_record_id;
  String? writeStatus;

  WriteUnit_Request(
      {this.current_unit, this.water_meter_record_id, this.writeStatus});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_unit'] = this.current_unit;
    data['water_meter_record_id'] = this.water_meter_record_id;
    data['new_round'] = this.writeStatus;
    return data;
  }
}
