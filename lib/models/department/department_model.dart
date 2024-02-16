class DepartmentRes {
  List<DepartmentData>? results;

  DepartmentRes({results});

  DepartmentRes.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <DepartmentData>[];
      json['results'].forEach((v) {
        results!.add(DepartmentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DepartmentData {
  String? id;
  String? name;
  String? org;
  String? role;

  DepartmentData({this.id, this.name, this.org, this.role});

  DepartmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    org = json['org'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['org'] = org;
    data['role'] = role;
    return data;
  }
}
