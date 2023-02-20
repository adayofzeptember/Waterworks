String tableHisInvoices = 'history_invoices';

class HisInvoicesFields {
  static final values = [
    id,
    data_id,
    customer_water_id,
    customer_name,
    water_number,
    area_number,
    sum,
    status,
    issue_date_format,
    vat,
    total,
    sum_service,
    bill_no,
  ];
  static const String id = '_id';
  static const String data_id = 'data_id';
  static const String customer_water_id = 'customer_water_id';
  static const String customer_name = 'customer_name';
  static const String water_number = 'water_number';
  static const String area_number = 'area_number';
  static const String sum = 'sum';
  static const String status = 'status';
  static const String issue_date_format = 'issue_date_format';
  static const String vat = 'vat';
  static const String total = 'total';
  static const String sum_service = 'sum_service';
  static const String bill_no = 'bill_no';
}

class HisInvoices {
  final int? id;
  final String data_id;
  final String customer_water_id;
  final String customer_name;
  final String water_number;
  final String area_number;
  final String sum;
  final String status;
  final String issue_date_format;
  final String vat;
  final String total;
  final String sum_service;
  final String bill_no;
  const HisInvoices({
    this.id,
    required this.data_id,
    required this.customer_water_id,
    required this.customer_name,
    required this.water_number,
    required this.area_number,
    required this.sum,
    required this.status,
    required this.issue_date_format,
    required this.vat,
    required this.total,
    required this.sum_service,
    required this.bill_no,
  });

  HisInvoices copy({
    int? id,
    String? data_id,
    String? customer_water_id,
    String? customer_name,
    String? water_number,
    String? area_number,
    String? sum,
    String? status,
    String? issue_date_format,
    String? vat,
    String? total,
    String? sum_service,
    String? bill_no,
  }) {
    return HisInvoices(
      id: id ?? this.id,
      data_id: data_id ?? this.data_id,
      customer_water_id: customer_water_id ?? this.customer_water_id,
      customer_name: customer_name ?? this.customer_name,
      water_number: water_number ?? this.water_number,
      area_number: area_number ?? this.area_number,
      sum: sum ?? this.sum,
      status: status ?? this.status,
      issue_date_format: issue_date_format ?? this.issue_date_format,
      vat: vat ?? this.vat,
      total: total ?? this.total,
      sum_service: sum_service ?? this.sum_service,
      bill_no: bill_no ?? this.bill_no,
    );
  }

  static HisInvoices fromJson(Map<String, Object?> json) => HisInvoices(
        id: json[HisInvoicesFields.id] as int?,
        data_id: json[HisInvoicesFields.data_id] as String,
        customer_water_id: json[HisInvoicesFields.customer_water_id] as String,
        customer_name: json[HisInvoicesFields.customer_name] as String,
        water_number: json[HisInvoicesFields.water_number] as String,
        area_number: json[HisInvoicesFields.area_number] as String,
        sum: json[HisInvoicesFields.sum] as String,
        status: json[HisInvoicesFields.status] as String,
        issue_date_format: json[HisInvoicesFields.issue_date_format] as String,
        vat: json[HisInvoicesFields.vat] as String,
        total: json[HisInvoicesFields.total] as String,
        sum_service: json[HisInvoicesFields.sum_service] as String,
        bill_no: json[HisInvoicesFields.bill_no] as String,
      );
  Map<String, Object?> toJson() => {
        HisInvoicesFields.id: id,
        HisInvoicesFields.data_id: data_id,
        HisInvoicesFields.customer_water_id: customer_water_id,
        HisInvoicesFields.customer_name: customer_name,
        HisInvoicesFields.water_number: water_number,
        HisInvoicesFields.area_number: area_number,
        HisInvoicesFields.sum: sum,
        HisInvoicesFields.status: status,
        HisInvoicesFields.issue_date_format: issue_date_format,
        HisInvoicesFields.vat: vat,
        HisInvoicesFields.total: total,
        HisInvoicesFields.sum_service: sum_service,
        HisInvoicesFields.bill_no: bill_no,
      };
}
