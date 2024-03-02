class AttendanceRes {
  int? count;

  List<AttendanceData> results = [];

  AttendanceRes({count, next, previous, results});

  AttendanceRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <AttendanceData>[];
      json['results'].forEach((v) {
        results.add(AttendanceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;

    if (results.isNotEmpty) {
      data['results'] = results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceData {
  String? id;
  String? user;
  String? status;
  List<LeaveDates> leaveDates = [];

  AttendanceData({id, user, status, leaveDates});

  AttendanceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    status = json['status'];
    if (json['leave_dates'] != null) {
      leaveDates = <LeaveDates>[];
      json['leave_dates'].forEach((v) {
        leaveDates.add(LeaveDates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['status'] = status;
    if (leaveDates.isNotEmpty) {
      data['leave_dates'] = leaveDates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveDates {
  String? id;
  String? date;
  String? type;
  String? leaveType;
  String? status;

  LeaveDates({id, date, type, leaveType, status});

  LeaveDates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    type = json['type'];
    leaveType = json['leave_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['type'] = type;
    data['leave_type'] = leaveType;
    data['status'] = status;
    return data;
  }
}
