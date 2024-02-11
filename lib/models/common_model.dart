class CommonRes {
  bool? success;
  String? message;

  CommonRes({success, data, message});

  CommonRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json["data"]['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;

    dataResponse["data"]['detail'] = message;
    return dataResponse;
  }
}
