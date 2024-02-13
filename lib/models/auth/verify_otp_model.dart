class OTPVerify {
  bool? success;
  String? message;

  OTPVerify({success, data, message});

  OTPVerify.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json["message"] != null) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;
    return dataResponse;
  }
}
