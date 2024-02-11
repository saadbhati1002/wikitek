class UserRes {
  bool? success;
  UserData? userData;
  String? message;

  UserRes({success, data, message});

  UserRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    userData = json['data'] != null ? UserData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['success'] = success;
    if (userData != null) {
      dataResponse['data'] = userData!.toJson();
    }
    dataResponse['message'] = message;
    return dataResponse;
  }
}

class UserData {
  String? firstName;
  String? lastName;
  String? userId;
  String? mobile;
  String? email;
  List<Marketplace>? marketplace;
  Org? org;
  List<Dept>? dept;
  // List<Null>? subscription;
  bool? online;
  bool? active;
  AuthToken? authToken;

  UserData(
      {firstName,
      lastName,
      userId,
      mobile,
      email,
      marketplace,
      org,
      dept,
      // subscription,
      online,
      active,
      authToken});

  UserData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    userId = json['user_id'];
    mobile = json['mobile'];
    email = json['email'];
    if (json['marketplace'] != null) {
      marketplace = <Marketplace>[];
      json['marketplace'].forEach((v) {
        marketplace!.add(Marketplace.fromJson(v));
      });
    }
    org = json['org'] != null ? Org.fromJson(json['org']) : null;
    if (json['dept'] != null) {
      dept = <Dept>[];
      json['dept'].forEach((v) {
        dept!.add(Dept.fromJson(v));
      });
    }
    // if (json['subscription'] != null) {
    //   subscription = <Null>[];
    //   json['subscription'].forEach((v) {
    //     subscription!.add(Null.fromJson(v));
    //   });
    // }
    online = json['online'];
    active = json['active'];
    authToken = json['auth_token'] != null
        ? AuthToken.fromJson(json['auth_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_id'] = userId;
    data['mobile'] = mobile;
    data['email'] = email;
    if (marketplace != null) {
      data['marketplace'] = marketplace!.map((v) => v.toJson()).toList();
    }
    if (org != null) {
      data['org'] = org!.toJson();
    }
    if (dept != null) {
      data['dept'] = dept!.map((v) => v.toJson()).toList();
    }
    // if (subscription != null) {
    //   data['subscription'] = subscription!.map((v) => v.toJson()).toList();
    // }
    data['online'] = online;
    data['active'] = active;
    if (authToken != null) {
      data['auth_token'] = authToken!.toJson();
    }
    return data;
  }
}

class Marketplace {
  String? id;
  String? marketplaceName;
  // Null? color;
  // Null? logo;
  String? org;

  Marketplace({id, marketplaceName, color, logo, org});

  Marketplace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    marketplaceName = json['marketplace_name'];
    // color = json['color'];
    // logo = json['logo'];
    org = json['org'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['marketplace_name'] = marketplaceName;
    // data['color'] = color;
    // data['logo'] = logo;
    data['org'] = org;
    return data;
  }
}

class Org {
  String? id;
  // List<Null>? banks;
  Country? country;
  String? created;
  String? modified;
  String? orgCode;
  String? companyType;
  String? companyName;
  // Null? logo;
  String? address;
  String? panNo;
  // Null? panCert;
  String? pincode;
  String? contactPerson;
  int? paymentTerm;
  // Null? marketplace;
  // List<Null>? metaTags;
  // List<Null>? role;

  Org(
      {id,
      banks,
      country,
      created,
      modified,
      orgCode,
      companyType,
      companyName,
      logo,
      address,
      panNo,
      panCert,
      pincode,
      contactPerson,
      paymentTerm,
      marketplace,
      metaTags,
      role});

  Org.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // if (json['banks'] != null) {
    //   banks = <Null>[];
    //   json['banks'].forEach((v) {
    //     banks!.add(new Null.fromJson(v));
    //   });
    // }
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    created = json['created'];
    modified = json['modified'];
    orgCode = json['org_code'];
    companyType = json['company_type'];
    companyName = json['company_name'];
    // logo = json['logo'];
    address = json['address'];
    panNo = json['pan_no'];
    // panCert = json['pan_cert'];
    pincode = json['pincode'];
    contactPerson = json['contact_person'];
    paymentTerm = json['payment_term'];
    // marketplace = json['marketplace'];
    // if (json['meta_tags'] != null) {
    //   metaTags = <Null>[];
    //   json['meta_tags'].forEach((v) {
    //     metaTags!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['role'] != null) {
    //   role = <Null>[];
    //   json['role'].forEach((v) {
    //     role!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // if (banks != null) {
    //   data['banks'] = banks!.map((v) => v.toJson()).toList();
    // }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['created'] = created;
    data['modified'] = modified;
    data['org_code'] = orgCode;
    data['company_type'] = companyType;
    data['company_name'] = companyName;
    // data['logo'] = logo;
    data['address'] = address;
    data['pan_no'] = panNo;
    // data['pan_cert'] = panCert;
    data['pincode'] = pincode;
    data['contact_person'] = contactPerson;
    data['payment_term'] = paymentTerm;
    // data['marketplace'] = marketplace;
    // if (metaTags != null) {
    //   data['meta_tags'] = metaTags!.map((v) => v.toJson()).toList();
    // }
    // if (role != null) {
    //   data['role'] = role!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Country {
  String? id;
  String? created;
  String? modified;
  String? name;
  // Null? slug;
  String? region;
  String? code;
  String? currencyName;
  // Null? postalCodeFormat;
  // Null? postalCodeRegex;
  String? currency;

  Country(
      {id,
      created,
      modified,
      name,
      slug,
      region,
      code,
      currencyName,
      postalCodeFormat,
      postalCodeRegex,
      currency});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    name = json['name'];
    // slug = json['slug'];
    region = json['region'];
    code = json['code'];
    currencyName = json['currency_name'];
    // postalCodeFormat = json['postal_code_format'];
    // postalCodeRegex = json['postal_code_regex'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['name'] = name;
    // data['slug'] = slug;
    data['region'] = region;
    data['code'] = code;
    data['currency_name'] = currencyName;
    // data['postal_code_format'] = postalCodeFormat;
    // data['postal_code_regex'] = postalCodeRegex;
    data['currency'] = currency;
    return data;
  }
}

class Dept {
  String? id;
  String? user;
  Role? role;
  String? department;

  Dept({id, user, role, department});

  Dept.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    department = json['deparment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['deparment'] = department;
    return data;
  }
}

class Role {
  String? name;

  Role({name});

  Role.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class AuthToken {
  String? access;
  String? refresh;

  AuthToken({access, refresh});

  AuthToken.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['refresh'] = refresh;
    return data;
  }
}
