import 'package:wikitek/models/lead/lead_model.dart';

class PartAddRes {
  bool? success;
  List<Parts>? parts = [];
  PartAddRes({success, data, this.parts});

  PartAddRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json["data"]['parts'] != null) {
      parts = <Parts>[];
      json["data"]['parts'].forEach((v) {
        parts!.add(Parts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};

    dataResponse['success'] = success;
    return dataResponse;
  }
}
