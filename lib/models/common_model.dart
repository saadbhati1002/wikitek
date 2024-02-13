class CommonRes {
  bool? success;
  String? message;

  CommonRes({success, data, message});

  CommonRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json["message"] != null) {
      message = json["message"];
    } else if (json["data"] != null) {
      if (json["data"]['detail'] != null) {
        message = json["data"]['detail'];
      }
    } else if (json["data"] != null) {
      if (json["data"]['message'] != null) {
        message = json["data"]['message'];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;
    return dataResponse;
  }
}
