class SalesOrderRes {
  int? count;

  List<SalesOrderData>? results;

  SalesOrderRes({count, results});

  SalesOrderRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <SalesOrderData>[];
      json['results'].forEach((v) {
        results!.add(SalesOrderData.fromJson(v));
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

class SalesOrderData {
  String? id;
  Org? org;
  Org? client;
  SubOrg? subOrg;
  Department? department;
  List<Parts> parts = [];
  BillingAddress? billingAddress;
  BillingAddress? shippingAddress;
  PaymentTerm? paymentTerm;
  PaymentTerm? deliveryTerm;
  TransportationTerm? transportationTerm;
  ContactTo? contactTo;
  // List<Null>? salesOrderDocument;
  String? created;
  String? modified;
  String? poDate;
  String? expectedInvDate;
  String? refPo;
  String? soId;
  String? comments;
  bool? isActive;
  bool? isApproved;
  String? total;
  String? description;
  String? soStatus;
  String? createdBy;
  String? salesLead;

  SalesOrderData(
      {id,
      org,
      client,
      subOrg,
      department,
      parts,
      billingAddress,
      shippingAddress,
      paymentTerm,
      deliveryTerm,
      transportationTerm,
      contactTo,
      salesOrderDocument,
      created,
      modified,
      poDate,
      expectedInvDate,
      refPo,
      soId,
      comments,
      isActive,
      isApproved,
      total,
      description,
      soStatus,
      createdBy,
      salesLead});

  SalesOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    org = json['org'] != null ? Org.fromJson(json['org']) : null;
    client = json['client'] != null ? Org.fromJson(json['client']) : null;
    subOrg = json['sub_org'] != null ? SubOrg.fromJson(json['sub_org']) : null;
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    if (json['parts'] != null) {
      parts = <Parts>[];
      json['parts'].forEach((v) {
        parts.add(Parts.fromJson(v));
      });
    }
    billingAddress = json['billing_address'] != null
        ? BillingAddress.fromJson(json['billing_address'])
        : null;
    shippingAddress = json['shipping_address'] != null
        ? BillingAddress.fromJson(json['shipping_address'])
        : null;
    paymentTerm = json['payment_term'] != null
        ? PaymentTerm.fromJson(json['payment_term'])
        : null;
    deliveryTerm = json['delivery_term'] != null
        ? PaymentTerm.fromJson(json['delivery_term'])
        : null;
    transportationTerm = json['transportation_term'] != null
        ? TransportationTerm.fromJson(json['transportation_term'])
        : null;
    contactTo = json['contact_to'] != null
        ? ContactTo.fromJson(json['contact_to'])
        : null;
    // if (json['salesOrderDocument'] != null) {
    //   salesOrderDocument = <Null>[];
    //   json['salesOrderDocument'].forEach((v) {
    //     salesOrderDocument!.add( Null.fromJson(v));
    //   });
    // }
    created = json['created'];
    modified = json['modified'];
    poDate = json['po_date'];
    expectedInvDate = json['expected_inv_date'];
    refPo = json['ref_po'];
    soId = json['so_id'];
    comments = json['comments'];
    isActive = json['is_active'];
    isApproved = json['is_approved'];
    total = json['total'];
    description = json['description'];
    soStatus = json['so_status'];
    createdBy = json['created_by'];
    salesLead = json['sales_lead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (org != null) {
      data['org'] = org!.toJson();
    }
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (subOrg != null) {
      data['sub_org'] = subOrg!.toJson();
    }
    if (department != null) {
      data['department'] = department!.toJson();
    }
    if (parts.isNotEmpty) {
      data['parts'] = parts.map((v) => v.toJson()).toList();
    }
    if (billingAddress != null) {
      data['billing_address'] = billingAddress!.toJson();
    }
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress!.toJson();
    }
    if (paymentTerm != null) {
      data['payment_term'] = paymentTerm!.toJson();
    }
    if (deliveryTerm != null) {
      data['delivery_term'] = deliveryTerm!.toJson();
    }
    if (transportationTerm != null) {
      data['transportation_term'] = transportationTerm!.toJson();
    }
    if (contactTo != null) {
      data['contact_to'] = contactTo!.toJson();
    }
    // if (salesOrderDocument != null) {
    //   data['salesOrderDocument'] = salesOrderDocument!.map((v) => v.toJson()).toList();
    // }
    data['created'] = created;
    data['modified'] = modified;
    data['po_date'] = poDate;
    data['expected_inv_date'] = expectedInvDate;
    data['ref_po'] = refPo;
    data['so_id'] = soId;
    data['comments'] = comments;
    data['is_active'] = isActive;
    data['is_approved'] = isApproved;
    data['total'] = total;
    data['description'] = description;
    data['so_status'] = soStatus;
    data['created_by'] = createdBy;
    data['sales_lead'] = salesLead;
    return data;
  }
}

class Org {
  String? id;
  String? companyName;
  bool? isSelected;

  Org({this.id, this.companyName, this.isSelected});

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

class Department {
  String? id;
  String? name;
  String? org;
  String? role;
  bool? isSelected;

  Department({this.id, this.name, this.org, this.role, this.isSelected});

  Department.fromJson(Map<String, dynamic> json) {
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

class Parts {
  String? id;
  PartsId? partsId;
  String? created;
  String? modified;
  int? quantity;
  String? partsNo;
  double? price;
  String? gst;
  String? netPrice;
  String? extendedGrossPrice;
  String? shortDescription;
  String? soId;

  Parts(
      {id,
      partsId,
      created,
      modified,
      quantity,
      partsNo,
      price,
      gst,
      netPrice,
      extendedGrossPrice,
      shortDescription,
      soId});

  Parts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partsId =
        json['parts_id'] != null ? PartsId.fromJson(json['parts_id']) : null;
    created = json['created'];
    modified = json['modified'];
    quantity = json['quantity'];
    partsNo = json['parts_no'];
    price = json['price'];
    gst = json['gst'];
    netPrice = json['net_price'];
    extendedGrossPrice = json['extd_gross_price'];
    shortDescription = json['short_description'];
    soId = json['so_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (partsId != null) {
      data['parts_id'] = partsId!.toJson();
    }
    data['created'] = created;
    data['modified'] = modified;
    data['quantity'] = quantity;
    data['parts_no'] = partsNo;
    data['price'] = price;
    data['gst'] = gst;
    data['net_price'] = netPrice;
    data['extd_gross_price'] = extendedGrossPrice;
    data['short_description'] = shortDescription;
    data['so_id'] = soId;
    return data;
  }
}

class PartsId {
  String? id;
  String? partNumber;
  bool? serialization;

  PartsId({id, partNumber, serialization});

  PartsId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partNumber = json['part_number'];
    serialization = json['serialization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['part_number'] = partNumber;
    data['serialization'] = serialization;
    return data;
  }
}

class BillingAddress {
  String? id;
  String? created;
  String? modified;
  String? address;
  String? gstNo;
  String? gstCert;
  String? org;
  int? addressType;
  String? pincode;
  String? country;

  BillingAddress(
      {id,
      created,
      modified,
      address,
      gstNo,
      gstCert,
      org,
      addressType,
      pincode,
      country});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    address = json['address'];
    gstNo = json['gst_no'];
    gstCert = json['gst_cert'];
    org = json['org'];
    addressType = json['address_type'];
    pincode = json['pincode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['address'] = address;
    data['gst_no'] = gstNo;
    data['gst_cert'] = gstCert;
    data['org'] = org;
    data['address_type'] = addressType;
    data['pincode'] = pincode;
    data['country'] = country;
    return data;
  }
}

class PaymentTerm {
  int? id;
  String? term;

  PaymentTerm({id, term});

  PaymentTerm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    term = json['term'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['term'] = term;
    return data;
  }
}

class TransportationTerm {
  int? id;
  String? name;

  TransportationTerm({id, name});

  TransportationTerm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ContactTo {
  String? id;
  String? email;
  String? mobile;
  String? firstName;
  String? lastName;
  String? createdAt;
  bool? isActive;

  ContactTo({id, email, mobile, firstName, lastName, createdAt, isActive});

  ContactTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    mobile = json['mobile'];
    firstName = json['first_name'];
    lastName = json['last_name'];
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
    data['created_at'] = createdAt;
    data['is_active'] = isActive;
    return data;
  }
}
