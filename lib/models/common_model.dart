class CommonRes {
  bool? success;
  String? message;

  CommonRes({success, data, message});

  CommonRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json["data"]['detail'] != null) {
      message = json["data"]['detail'];
    }
    if (json["data"]['message'] != null) {
      message = json["data"]['message'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;

    dataResponse["data"]['detail'] = message;
    return dataResponse;
  }
}
