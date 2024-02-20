class UserListRes {
  int? count;

  List<UserData>? results;

  UserListRes({count, next, previous, results});

  UserListRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <UserData>[];
      json['results'].forEach((v) {
        results!.add(UserData.fromJson(v));
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

class UserData {
  String? id;
  String? email;
  String? mobile;
  String? firstName;
  String? lastName;
  String? type;
  String? doj;
  String? doc;
  Org? org;
  String? createdAt;
  bool? isActive;

  UserData(
      {id,
      email,
      mobile,
      firstName,
      lastName,
      type,
      doj,
      doc,
      org,
      createdAt,
      isActive});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    mobile = json['mobile'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    type = json['type'];
    doj = json['doj'];
    doc = json['doc'];
    org = json['org'] != null ? Org.fromJson(json['org']) : null;
    createdAt = json['created_at'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['mobile'] = mobile;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['type'] = type;
    data['doj'] = doj;
    data['doc'] = doc;
    if (org != null) {
      data['org'] = org!.toJson();
    }
    data['created_at'] = createdAt;
    data['is_active'] = isActive;
    return data;
  }
}

class Org {
  String? companyName;

  Org({companyName});

  Org.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_name'] = companyName;
    return data;
  }
}
