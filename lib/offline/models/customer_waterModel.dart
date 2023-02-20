String tableCustomers = 'customer_water';

class CustomersFields {
  static final values = [
    id,
    data_id,
    customer_id,
    water_number,
    area_number,
    meter_number,
    address,
    type_id,
    name,
    status_debtor,
    status_discount,
    road,
  ];
  static const String id = '_id';
  static const String data_id = 'data_id';
  static const String customer_id = 'customer_id';
  static const String water_number = 'water_number';
  static const String area_number = 'area_number';
  static const String meter_number = 'meter_number';
  static const String address = 'address';
  static const String type_id = 'type_id';
  static const String name = 'name';
  static const String status_debtor = 'status_debtor';
  static const String status_discount = 'status_discount';
  static const String road = 'road';
}

class Customers {
  final int? id;
  final String data_id;
  final String customer_id;
  final String water_number;
  final String area_number;
  final String meter_number;
  final String address;
  final String type_id;
  final String name;
  final String status_debtor;
  final String status_discount;
  final String road;
  const Customers({
    this.id,
    required this.data_id,
    required this.customer_id,
    required this.water_number,
    required this.area_number,
    required this.meter_number,
    required this.address,
    required this.type_id,
    required this.name,
    required this.status_debtor,
    required this.status_discount,
    required this.road,
  });

  Customers copy({
    int? id,
    String? data_id,
    String? customer_id,
    String? water_number,
    String? area_number,
    String? meter_number,
    String? address,
    String? type_id,
    String? name,
    String? status_debtor,
    String? status_discount,
    String? road,
  }) {
    return Customers(
      id: id ?? this.id,
      data_id: data_id ?? this.data_id,
      customer_id: customer_id ?? this.customer_id,
      water_number: water_number ?? this.water_number,
      area_number: area_number ?? this.area_number,
      meter_number: meter_number ?? this.meter_number,
      address: address ?? this.address,
      type_id: type_id ?? this.type_id,
      name: name ?? this.name,
      status_debtor: status_debtor ?? this.status_debtor,
      status_discount: status_discount ?? this.status_discount,
      road: road ?? this.road,
    );
  }

  static Customers fromJson(Map<String, Object?> json) => Customers(
        id: json[CustomersFields.id] as int?,
        data_id: json[CustomersFields.data_id] as String,
        customer_id: json[CustomersFields.customer_id] as String,
        water_number: json[CustomersFields.water_number] as String,
        area_number: json[CustomersFields.area_number] as String,
        meter_number: json[CustomersFields.meter_number] as String,
        address: json[CustomersFields.address] as String,
        type_id: json[CustomersFields.type_id] as String,
        name: json[CustomersFields.name] as String,
        status_debtor: json[CustomersFields.status_debtor] as String,
        status_discount: json[CustomersFields.status_discount] as String,
        road: json[CustomersFields.road] as String,
      );
  Map<String, Object?> toJson() => {
        CustomersFields.id: id,
        CustomersFields.data_id: data_id,
        CustomersFields.customer_id: customer_id,
        CustomersFields.water_number: water_number,
        CustomersFields.area_number: area_number,
        CustomersFields.meter_number: meter_number,
        CustomersFields.address: address,
        CustomersFields.type_id: type_id,
        CustomersFields.name: name,
        CustomersFields.status_debtor: status_debtor,
        CustomersFields.status_discount: status_discount,
        CustomersFields.road: road,
      };
}
