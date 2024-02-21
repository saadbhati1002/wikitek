class InvoiceRes {
  int? count;

  List<InvoiceData>? results;

  InvoiceRes({count, next, previous, results});

  InvoiceRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <InvoiceData>[];
      json['results'].forEach((v) {
        results!.add(InvoiceData.fromJson(v));
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

class InvoiceData {
  String? id;
  Org? org;
  InvoiceType? invoiceType;
  BillingAddress? billingAddress;
  BillingAddress? shippingAddress;
  PaymentTerm? paymentTerm;
  CreatedBy? createdBy;
  SaleOrder? saleOrder;
  Dept? dept;
  List<PartsInvoice>? partsInvoice;
  String? created;
  String? modified;
  String? invoiceNumber;
  String? poNumber;
  String? paymentDate;
  String? deliveryTerm;
  String? invoiceDate;
  bool? approved;
  bool? assigned;
  String? invoiceComment;
  String? total;
  double? shipmentCharges;
  String? amountPaid;
  String? currentOrg;

  InvoiceData({
    id,
    org,
    invoiceType,
    billingAddress,
    shippingAddress,
    paymentTerm,
    createdBy,
    saleOrder,
    dept,
    partsInvoice,
    created,
    modified,
    invoiceNumber,
    poNumber,
    paymentDate,
    deliveryTerm,
    invoiceDate,
    approved,
    assigned,
    invoiceComment,
    total,
    shipmentCharges,
    amountPaid,
    currentOrg,
  });

  InvoiceData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    shipmentCharges = json['shipment_charges'];
    amountPaid = json['amount_paid'].toString();
    id = json['id'];
    org = json['org'] != null ? Org.fromJson(json['org']) : null;

    invoiceType = json['invoice_type'] != null
        ? InvoiceType.fromJson(json['invoice_type'])
        : null;
    billingAddress = json['billing_address'] != null
        ? BillingAddress.fromJson(json['billing_address'])
        : null;
    shippingAddress = json['shipping_address'] != null
        ? BillingAddress.fromJson(json['shipping_address'])
        : null;
    paymentTerm = json['payment_term'] != null
        ? PaymentTerm.fromJson(json['payment_term'])
        : null;
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    saleOrder = json['sale_order'] != null
        ? SaleOrder.fromJson(json['sale_order'])
        : null;
    dept = json['dept'] != null ? Dept.fromJson(json['dept']) : null;
    if (json['parts_invoice'] != null) {
      partsInvoice = <PartsInvoice>[];
      json['parts_invoice'].forEach((v) {
        partsInvoice!.add(PartsInvoice.fromJson(v));
      });
    }

    created = json['created'];
    modified = json['modified'];
    invoiceNumber = json['invoice_number'];
    poNumber = json['po_number'];
    paymentDate = json['payment_date'];
    deliveryTerm = json['delivery_term'];
    invoiceDate = json['invoice_date'];

    approved = json['approved'];
    assigned = json['assigned'];
    invoiceComment = json['invoice_comment'];

    currentOrg = json['current_org'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (org != null) {
      data['org'] = org!.toJson();
    }

    if (invoiceType != null) {
      data['invoice_type'] = invoiceType!.toJson();
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
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (saleOrder != null) {
      data['sale_order'] = saleOrder!.toJson();
    }
    if (dept != null) {
      data['dept'] = dept!.toJson();
    }
    if (partsInvoice != null) {
      data['parts_invoice'] = partsInvoice!.map((v) => v.toJson()).toList();
    }

    data['created'] = created;
    data['modified'] = modified;
    data['invoice_number'] = invoiceNumber;
    data['po_number'] = poNumber;
    data['payment_date'] = paymentDate;
    data['delivery_term'] = deliveryTerm;
    data['invoice_date'] = invoiceDate;

    data['approved'] = approved;
    data['assigned'] = assigned;
    data['invoice_comment'] = invoiceComment;

    data['total'] = total;
    data['shipment_charges'] = shipmentCharges;
    data['amount_paid'] = amountPaid;
    data['current_org'] = currentOrg;

    return data;
  }
}

class Org {
  String? id;

  Country? country;
  String? created;
  String? modified;
  String? orgCode;
  String? companyType;
  String? companyName;

  String? address;
  String? panNo;

  String? pincode;

  int? paymentTerm;

  List<String>? role;
  bool isSelected = false;

  Org(
      {id,
      country,
      created,
      modified,
      orgCode,
      companyType,
      companyName,
      address,
      panNo,
      pincode,
      paymentTerm,
      role});

  Org.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    created = json['created'];
    modified = json['modified'];
    orgCode = json['org_code'];
    companyType = json['company_type'];
    companyName = json['company_name'];

    address = json['address'];
    panNo = json['pan_no'];

    pincode = json['pincode'];

    paymentTerm = json['payment_term'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    data['company_name'] = companyName;

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

  Country({id, created, modified, name, region, code, currencyName, currency});

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

class InvoiceType {
  String? id;
  String? created;
  String? modified;
  String? name;

  InvoiceType({id, created, modified, name});

  InvoiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['name'] = name;
    return data;
  }
}

class BillingAddress {
  String? id;
  Org? org;
  Pincode? pincode;
  Country? country;
  String? created;
  String? modified;
  String? address;
  String? gstNo;

  int? addressType;

  BillingAddress(
      {id,
      org,
      pincode,
      country,
      created,
      modified,
      address,
      gstNo,
      addressType});

  BillingAddress.fromJson(Map<String, dynamic> json) {
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

    data['address_type'] = addressType;
    return data;
  }
}

class Pincode {
  String? id;
  String? created;
  String? modified;
  String? pinCode;

  String? district;

  Pincode({id, created, modified, pinCode, district});

  Pincode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    pinCode = json['pin_code'];

    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['pin_code'] = pinCode;

    data['district'] = district;
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

class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  Org? org;

  CreatedBy({id, firstName, lastName, mobile, email, org});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    org = json['org'] != null ? Org.fromJson(json['org']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['email'] = email;
    if (org != null) {
      data['org'] = org!.toJson();
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

class SaleOrder {
  String? id;
  String? soId;
  String? refPo;
  String? poDate;

  String? client;

  SaleOrder({id, soId, refPo, poDate, client});

  SaleOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soId = json['so_id'];
    refPo = json['ref_po'];
    poDate = json['po_date'];

    client = json['client'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['so_id'] = soId;
    data['ref_po'] = refPo;
    data['po_date'] = poDate;

    data['client'] = client;
    return data;
  }
}

class Dept {
  String? id;
  String? name;
  bool isSelected = false;
  Dept({id, name});

  Dept.fromJson(Map<String, dynamic> json) {
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

class PartsInvoice {
  String? id;
  PartsNo? partsNo;
  String? created;
  String? modified;
  double? quantity;
  String? customerPartNo;
  double? price;
  int? warranty;
  String? shortDescription;
  String? invoice;

  PartsInvoice({
    id,
    partsNo,
    created,
    modified,
    quantity,
    customerPartNo,
    price,
    warranty,
    shortDescription,
    invoice,
  });

  PartsInvoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partsNo =
        json['parts_no'] != null ? PartsNo.fromJson(json['parts_no']) : null;
    created = json['created'];
    modified = json['modified'];
    quantity = json['quantity'];
    customerPartNo = json['customer_part_no'];
    price = json['price'];
    warranty = json['warranty'];
    shortDescription = json['short_description'];
    invoice = json['invoice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (partsNo != null) {
      data['parts_no'] = partsNo!.toJson();
    }
    data['created'] = created;
    data['modified'] = modified;
    data['quantity'] = quantity;
    data['customer_part_no'] = customerPartNo;
    data['price'] = price;
    data['warranty'] = warranty;
    data['short_description'] = shortDescription;
    data['invoice'] = invoice;

    return data;
  }
}

class PartsNo {
  String? id;
  PartType? partType;
  PartType? uom;
  GstItm? gstItm;
  String? created;
  String? modified;
  String? internalPartNo;
  String? partNumber;
  String? customerPartNumber;
  bool? bom;
  String? shortDescription;
  String? longDescription;
  double? mrp;
  String? weight;
  String? length;
  String? breadth;
  String? height;
  bool? serialization;
  bool? oemSpecific;
  bool? isActive;
  int? warrantyPeriod;
  String? warrantyTerms;
  double? packingCharge;
  String? manufacturer;
  int? partCategory;
  int? subCategory;

  PartsNo({
    id,
    partType,
    uom,
    gstItm,
    created,
    modified,
    internalPartNo,
    partNumber,
    customerPartNumber,
    bom,
    shortDescription,
    longDescription,
    mrp,
    weight,
    length,
    breadth,
    height,
    serialization,
    oemSpecific,
    isActive,
    warrantyPeriod,
    warrantyTerms,
    packingCharge,
    manufacturer,
    partCategory,
    subCategory,
  });

  PartsNo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partType =
        json['part_type'] != null ? PartType.fromJson(json['part_type']) : null;
    uom = json['uom'] != null ? PartType.fromJson(json['uom']) : null;
    gstItm = json['gst_itm'] != null ? GstItm.fromJson(json['gst_itm']) : null;
    created = json['created'];
    modified = json['modified'];
    internalPartNo = json['internal_part_no'];
    partNumber = json['part_number'];
    customerPartNumber = json['customer_part_number'];
    bom = json['bom'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    mrp = json['mrp'];
    weight = json['weight'];
    length = json['length'];
    breadth = json['breadth'];
    height = json['height'];
    serialization = json['serialization'];
    oemSpecific = json['oem_specific'];
    isActive = json['is_active'];
    warrantyPeriod = json['warranty_period'];
    warrantyTerms = json['warranty_terms'];
    packingCharge = json['packing_charge'];
    manufacturer = json['manufacturer'];
    partCategory = json['part_category'];
    subCategory = json['sub_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (partType != null) {
      data['part_type'] = partType!.toJson();
    }
    if (uom != null) {
      data['uom'] = uom!.toJson();
    }
    if (gstItm != null) {
      data['gst_itm'] = gstItm!.toJson();
    }
    data['created'] = created;
    data['modified'] = modified;
    data['internal_part_no'] = internalPartNo;
    data['part_number'] = partNumber;
    data['customer_part_number'] = customerPartNumber;
    data['bom'] = bom;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['mrp'] = mrp;
    data['weight'] = weight;
    data['length'] = length;
    data['breadth'] = breadth;
    data['height'] = height;
    data['serialization'] = serialization;
    data['oem_specific'] = oemSpecific;
    data['is_active'] = isActive;
    data['warranty_period'] = warrantyPeriod;
    data['warranty_terms'] = warrantyTerms;
    data['packing_charge'] = packingCharge;
    data['manufacturer'] = manufacturer;
    data['part_category'] = partCategory;
    data['sub_category'] = subCategory;

    return data;
  }
}

class PartType {
  int? id;
  String? created;
  String? modified;
  String? name;

  PartType({id, created, modified, name});

  PartType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['name'] = name;
    return data;
  }
}

class GstItm {
  String? id;
  List<CountryGst>? countryGst;
  String? hsnOrSac;
  String? description;

  GstItm({id, countryGst, hsnOrSac, description});

  GstItm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['country_gst'] != null) {
      countryGst = <CountryGst>[];
      json['country_gst'].forEach((v) {
        countryGst!.add(CountryGst.fromJson(v));
      });
    }
    hsnOrSac = json['hsn_or_sac'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (countryGst != null) {
      data['country_gst'] = countryGst!.map((v) => v.toJson()).toList();
    }
    data['hsn_or_sac'] = hsnOrSac;
    data['description'] = description;
    return data;
  }
}

class CountryGst {
  String? id;
  double? gstPercent;
  Dept? countryCode;

  CountryGst({id, gstPercent, countryCode});

  CountryGst.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gstPercent = json['gst_percent'];
    countryCode = json['country_code'] != null
        ? Dept.fromJson(json['country_code'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gst_percent'] = gstPercent;
    if (countryCode != null) {
      data['country_code'] = countryCode!.toJson();
    }
    return data;
  }
}
