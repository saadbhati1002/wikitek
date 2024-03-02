class OrgHolidayRes {
  int? count;

  List<OrgHolidayData>? results;

  OrgHolidayRes({count, results});

  OrgHolidayRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <OrgHolidayData>[];
      json['results'].forEach((v) {
        results!.add(OrgHolidayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;

    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrgHolidayData {
  String? id;
  String? type;
  String? startYear;
  Org? org;
  String? createdBy;
  bool? isActive;
  String? created;
  List<HolidayDate> holidayDate = [];

  OrgHolidayData(
      {id, type, startYear, org, createdBy, isActive, created, holidayDate});

  OrgHolidayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    startYear = json['startyear'];
    org = json['org'] != null ? Org.fromJson(json['org']) : null;
    createdBy = json['created_by'];
    isActive = json['is_active'];
    created = json['created'];
    if (json['holiday_date'] != null) {
      holidayDate = <HolidayDate>[];
      json['holiday_date'].forEach((v) {
        holidayDate.add(HolidayDate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['startyear'] = startYear;
    if (org != null) {
      data['org'] = org!.toJson();
    }
    data['created_by'] = createdBy;
    data['is_active'] = isActive;
    data['created'] = created;
    if (holidayDate.isNotEmpty) {
      data['holiday_date'] = holidayDate.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Org {
  String? id;
  String? companyName;

  Org({id, companyName});

  Org.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    return data;
  }
}

class HolidayDate {
  String? id;
  String? date;

  HolidayDate({id, date});

  HolidayDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    return data;
  }
}
