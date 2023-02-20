String tableWater = 'water';

class WaterFields {
  static final values = [id, numPor, zone, numMeter, saveDate];
  static const String id = '_id';
  static const String numPor = 'num_por';
  static const String zone = 'zone';
  static const String numMeter = 'num_mater';
  static const String saveDate = 'save_date';
}

class Water {
  final int? id;
  final String numPor;
  final String zone;
  final String numMeter;
  final String saveDate;
  const Water({
    this.id,
    required this.numPor,
    required this.zone,
    required this.numMeter,
    required this.saveDate,
  });

  Water copy({
    int? id,
    String? numPor,
    String? zone,
    String? numMeter,
    String? saveDate,
  }) {
    return Water(
      id: id ?? this.id,
      numPor: numPor ?? this.numPor,
      zone: zone ?? this.zone,
      numMeter: numMeter ?? this.numMeter,
      saveDate: saveDate ?? this.saveDate,
    );
  }

  static Water fromJson(Map<String, Object?> json) => Water(
        id: json[WaterFields.id] as int?,
        numPor: json[WaterFields.numPor] as String,
        zone: json[WaterFields.zone] as String,
        numMeter: json[WaterFields.numMeter] as String,
        saveDate: json[WaterFields.saveDate] as String,
      );
  Map<String, Object?> toJson() => {
        WaterFields.id: id,
        WaterFields.numPor: numPor,
        WaterFields.zone: zone,
        WaterFields.numMeter: numMeter,
        WaterFields.saveDate: saveDate,
      };
}
