import 'package:wikitek/models/sales_order/sales_order_model.dart';

class SalesOrderPartAddRes {
  bool? success;
  List<Parts>? parts = [];
  SalesOrderPartAddRes({success, data, this.parts});

  SalesOrderPartAddRes.fromJson(Map<String, dynamic> json) {
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
