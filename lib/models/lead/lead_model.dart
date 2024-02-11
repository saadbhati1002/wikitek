class SalesLeadRes {
  int? count;
  dynamic next;
  dynamic previous;
  List<SalesLeadData>? results;

  SalesLeadRes({count, next, previous, results});

  SalesLeadRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <SalesLeadData>[];
      json['results'].forEach((v) {
        results!.add(SalesLeadData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesLeadData {
  String? leadNo;
  Org? org;
  Org? client;
  SubOrg? subOrg;
  Department? department;
  List<Parts>? parts;
  List<SalesLeadHistory>? salesLeadHistory;
  List<String>? salesLeadDocument;
  String? created;
  String? modified;
  String? leadId;
  String? expectedDate;
  String? expectedInvoiceDate;
  String? status;
  String? total;
  String? description;
  String? mobile;
  String? contactName;
  String? email;
  int? probability;

  SalesLeadData(
      {leadNo,
      org,
      client,
      subOrg,
      department,
      parts,
      salesLeadHistory,
      salesLeadDocument,
      created,
      modified,
      leadId,
      expectedDate,
      expectedInvoiceDate,
      status,
      total,
      description,
      mobile,
      contactName,
      email,
      probability});

  SalesLeadData.fromJson(Map<String, dynamic> json) {
    leadNo = json['lead_no'];
    org = json['org'] != null ? Org.fromJson(json['org']) : null;
    client = json['client'] != null ? Org.fromJson(json['client']) : null;
    subOrg = json['sub_org'] != null ? SubOrg.fromJson(json['sub_org']) : null;
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    if (json['parts'] != null) {
      parts = <Parts>[];
      json['parts'].forEach((v) {
        parts!.add(Parts.fromJson(v));
      });
    }
    if (json['sales_lead_history'] != null) {
      salesLeadHistory = <SalesLeadHistory>[];
      json['sales_lead_history'].forEach((v) {
        salesLeadHistory!.add(SalesLeadHistory.fromJson(v));
      });
    }
    if (json['sales_lead_document'] != null) {
      salesLeadDocument = <String>[];
      json['sales_lead_document'].forEach((v) {
        // salesLeadDocument!.add( String.fromJson(v));
      });
    }
    created = json['created'];
    modified = json['modified'];
    leadId = json['lead_id'];
    expectedDate = json['expected_date'];
    expectedInvoiceDate = json['expected_invoice_date'];
    status = json['status'];
    total = json['total'];
    description = json['description'];
    mobile = json['mobile'];
    contactName = json['contact_name'];
    email = json['email'];
    probability = json['probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lead_no'] = leadNo;
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
    if (parts != null) {
      data['parts'] = parts!.map((v) => v.toJson()).toList();
    }
    if (salesLeadHistory != null) {
      data['sales_lead_history'] =
          salesLeadHistory!.map((v) => v.toJson()).toList();
    }
    if (salesLeadDocument != null) {
      // data['sales_lead_document'] =
      //     salesLeadDocument!.map((v) => v.toJson()).toList();
    }
    data['created'] = created;
    data['modified'] = modified;
    data['lead_id'] = leadId;
    data['expected_date'] = expectedDate;
    data['expected_invoice_date'] = expectedInvoiceDate;
    data['status'] = status;
    data['total'] = total;
    data['description'] = description;
    data['mobile'] = mobile;
    data['contact_name'] = contactName;
    data['email'] = email;
    data['probability'] = probability;
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

  Department({id, name, org, role});

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
  String? leadPartId;
  PartId? partId;
  String? shortDescription;
  int? quantity;
  int? unitCost;
  String? status;
  String? gst;
  String? netPrice;
  String? expdGrossPrice;

  Parts(
      {leadPartId,
      partId,
      shortDescription,
      quantity,
      unitCost,
      status,
      gst,
      netPrice,
      expdGrossPrice});

  Parts.fromJson(Map<String, dynamic> json) {
    leadPartId = json['lead_part_id'];
    partId = json['part_id'] != null ? PartId.fromJson(json['part_id']) : null;
    shortDescription = json['short_description'];
    quantity = json['quantity'];
    unitCost = json['unit_cost'];
    status = json['status'];
    gst = json['gst'];
    netPrice = json['net_price'];
    expdGrossPrice = json['extd_gross_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lead_part_id'] = leadPartId;
    if (partId != null) {
      data['part_id'] = partId!.toJson();
    }
    data['short_description'] = shortDescription;
    data['quantity'] = quantity;
    data['unit_cost'] = unitCost;
    data['status'] = status;
    data['gst'] = gst;
    data['net_price'] = netPrice;
    data['extd_gross_price'] = expdGrossPrice;
    return data;
  }
}

class PartId {
  String? id;
  String? partNumber;
  bool? serialization;

  PartId({id, partNumber, serialization});

  PartId.fromJson(Map<String, dynamic> json) {
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

class SalesLeadHistory {
  String? id;
  CreatedBy? createdBy;
  String? date;
  String? comment;

  SalesLeadHistory({id, createdBy, date, comment});

  SalesLeadHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    date = json['date'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['date'] = date;
    data['comment'] = comment;
    return data;
  }
}

class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;

  CreatedBy({id, firstName, lastName, mobile, email});

  CreatedBy.fromJson(Map<String, dynamic> json) {
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
