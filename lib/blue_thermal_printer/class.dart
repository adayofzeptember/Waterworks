class PrinterConfig {
  String? name;
  String? address;
  int? type = 0;
  bool? connected = false;

  PrinterConfig({this.name, this.address, this.type, this.connected});

  PrinterConfig.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    type = json['type'];
    connected = json['connected'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['address'] = this.address;
    data['type'] = this.type;
    data['connected'] = this.connected;

    return data;
  }
}
