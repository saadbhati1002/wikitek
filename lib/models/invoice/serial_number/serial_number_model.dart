class SerialNumberRes {
  List<String>? serialNumbers;

  SerialNumberRes({this.serialNumbers});

  SerialNumberRes.fromJson(Map<String, dynamic> json) {
    serialNumbers = json['serial_numbers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serial_numbers'] = serialNumbers;
    return data;
  }
}
