String tableHisWater = 'history_water';

class HisWaterFields {
  static final values = [
    id,
    data_id,
    water_number,
    area_number,
    status,
    record_date,
    current_unit,
  ];
  static const String id = '_id';
  static const String data_id = 'data_id';
  static const String water_number = 'water_number';
  static const String area_number = 'area_number';
  static const String status = 'status';
  static const String record_date = 'record_date';
  static const String current_unit = 'current_unit';
}

class HisWater {
  final int? id;
  final String? data_id;
  final String? water_number;
  final String? area_number;
  final String? status;
  final String? record_date;
  final String? current_unit;
  const HisWater(
      {this.id,
      required this.data_id,
      required this.water_number,
      required this.area_number,
      required this.status,
      required this.record_date,
      required this.current_unit});

  HisWater copy({
    int? id,
    String? data_id,
    String? water_number,
    String? area_number,
    String? status,
    String? record_date,
    String? current_unit,
  }) {
    return HisWater(
      id: id ?? this.id,
      data_id: data_id ?? this.data_id,
      water_number: water_number ?? this.water_number,
      area_number: area_number ?? this.area_number,
      status: status ?? this.status,
      record_date: record_date ?? this.record_date,
      current_unit: current_unit ?? this.current_unit,
    );
  }

  static HisWater fromJson(Map<String, Object?> json) => HisWater(
        id: json[HisWaterFields.id] as int?,
        data_id: json[HisWaterFields.data_id] as String,
        water_number: json[HisWaterFields.water_number] as String,
        area_number: json[HisWaterFields.area_number] as String,
        status: json[HisWaterFields.status] as String,
        record_date: json[HisWaterFields.record_date] as String,
        current_unit: json[HisWaterFields.current_unit] as String,
      );
  Map<String, Object?> toJson() => {
        HisWaterFields.id: id,
        HisWaterFields.data_id: data_id,
        HisWaterFields.water_number: water_number,
        HisWaterFields.area_number: area_number,
        HisWaterFields.status: status,
        HisWaterFields.record_date: record_date,
        HisWaterFields.current_unit: current_unit,
      };
}
