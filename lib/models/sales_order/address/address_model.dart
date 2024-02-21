class AddressRes {
  int? count;
  List<AddressData>? results;

  AddressRes({count, next, previous, results});

  AddressRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = <AddressData>[];
      json['results'].forEach((v) {
        results!.add(AddressData.fromJson(v));
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

class AddressData {
  String? id;
  Org? org;
  Pincode? pincode;
  Country? country;
  String? created;
  String? modified;
  String? address;
  String? gstNo;
  String? gstCert;
  int? addressType;

  AddressData(
      {id,
      org,
      pincode,
      country,
      created,
      modified,
      address,
      gstNo,
      gstCert,
      addressType});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    org = json['org'] != null ? Org.fromJson(json['org']) : null;
    pincode =
        json['pincode'] != null ? Pincode.fromJson(json['pincode']) : null;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    created = json['created'];
    modified = json['modified'];
    address = json['address'];
    gstNo = json['gst_no'];
    gstCert = json['gst_cert'];
    addressType = json['address_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (org != null) {
      data['org'] = org!.toJson();
    }
    if (pincode != null) {
      data['pincode'] = pincode!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['created'] = created;
    data['modified'] = modified;
    data['address'] = address;
    data['gst_no'] = gstNo;
    data['gst_cert'] = gstCert;
    data['address_type'] = addressType;
    return data;
  }
}

class Org {
  String? companyName;
  ContactPerson? contactPerson;

  Org({companyName, contactPerson});

  Org.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    contactPerson = json['contact_person'] != null
        ? ContactPerson.fromJson(json['contact_person'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_name'] = companyName;
    if (contactPerson != null) {
      data['contact_person'] = contactPerson!.toJson();
    }
    return data;
  }
}

class ContactPerson {
  String? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;

  ContactPerson({id, firstName, lastName, mobile, email});

  ContactPerson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}

class Pincode {
  String? id;
  String? created;
  String? modified;
  String? pinCode;
  String? state;
  String? district;

  Pincode({id, created, modified, pinCode, state, district});

  Pincode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    pinCode = json['pin_code'];
    state = json['state'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['pin_code'] = pinCode;
    data['state'] = state;
    data['district'] = district;
    return data;
  }
}

class Country {
  String? id;
  String? created;
  String? modified;
  String? name;

  String? region;
  String? code;
  String? currencyName;

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

    region = json['region'];
    code = json['code'];
    currencyName = json['currency_name'];

    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['name'] = name;

    data['region'] = region;
    data['code'] = code;
    data['currency_name'] = currencyName;

    data['currency'] = currency;
    return data;
  }
}
