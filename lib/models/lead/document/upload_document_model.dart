class SalesLeadDocumentUploadRes {
  bool? success;
  String? attachment;

  SalesLeadDocumentUploadRes({success, data, attachment});

  SalesLeadDocumentUploadRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json["data"]["attachment"] != null) {
      attachment = json["data"]["attachment"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;
    return dataResponse;
  }
}
