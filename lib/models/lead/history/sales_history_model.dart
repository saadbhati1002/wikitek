class SalesHistoryRes {
  bool? success;
  String? id;

  SalesHistoryRes({success, data, id});

  SalesHistoryRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json["data"]["id"] != null) {
      id = json["data"]["id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;
    return dataResponse;
  }
}
