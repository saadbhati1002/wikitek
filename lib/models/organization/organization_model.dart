class OrganizationRes {
  int? count;

  List<OrganizationData>? results;

  OrganizationRes({count, next, previous, results});

  OrganizationRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <OrganizationData>[];
      json['results'].forEach((v) {
        results!.add(OrganizationData.fromJson(v));
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

class OrganizationData {
  String? id;
  String? created;
  String? modified;
  String? orgCode;
  String? companyType;
  String? companyName;
  String? address;
  String? panNo;
  String? pincode;
  String? country;
  ContactPerson? contactPerson;
  int? paymentTerm;
  List<SubOrg>? subOrg;

  OrganizationData(
      {id,
      created,
      modified,
      orgCode,
      companyType,
      companyName,
      address,
      panNo,
      pincode,
      country,
      contactPerson,
      paymentTerm,
      subOrg});

  OrganizationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    orgCode = json['org_code'];
    companyType = json['company_type'];
    companyName = json['company_name'];
    address = json['address'];
    panNo = json['pan_no'];
    pincode = json['pincode'];
    country = json['country'];
    contactPerson = json['contact_person'] != null
        ? ContactPerson.fromJson(json['contact_person'])
        : null;
    paymentTerm = json['payment_term'];
    if (json['suborg'] != null) {
      subOrg = <SubOrg>[];
      json['suborg'].forEach((v) {
        subOrg!.add(SubOrg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['org_code'] = orgCode;
    data['company_type'] = companyType;
    data['company_name'] = companyName;
    data['address'] = address;
    data['pan_no'] = panNo;
    data['pincode'] = pincode;
    data['country'] = country;
    if (contactPerson != null) {
      data['contact_person'] = contactPerson!.toJson();
    }
    data['payment_term'] = paymentTerm;
    if (subOrg != null) {
      data['suborg'] = subOrg!.map((v) => v.toJson()).toList();
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

class SubOrg {
  String? id;
  String? created;
  String? modified;
  String? orgCode;
  String? subCompanyName;
  String? org;
  String? contactPerson;

  SubOrg({id, created, modified, orgCode, subCompanyName, org, contactPerson});

  SubOrg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    orgCode = json['org_code'];
    subCompanyName = json['sub_company_name'];
    org = json['org'];
    contactPerson = json['contact_person'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['org_code'] = orgCode;
    data['sub_company_name'] = subCompanyName;
    data['org'] = org;
    data['contact_person'] = contactPerson;
    return data;
  }
}
