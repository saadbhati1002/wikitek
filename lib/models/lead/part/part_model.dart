class PartLeadRes {
  int? count;

  List<PartData> results = [];

  PartLeadRes({count, next, previous, results});

  PartLeadRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <PartData>[];
      json['results'].forEach((v) {
        results.add(PartData.fromJson(v));
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

class PartData {
  String? id;
  String? manufacturer;
  GstItm? gstItm;
  String? partType;
  String? partCategory;
  String? subCategory;
  String? uom;
  List<MarketPlace>? marketPlace;
  List<Documents>? documents;
  List<PartSpecs>? partSpecs;
  List<Prices>? prices;
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
  int? packingCharge;
  List<int>? metaTags;
  List<String>? oem;
  double? calculatedPrice;
  int quantity = 1;

  PartData(
      {id,
      manufacturer,
      gstItm,
      partType,
      partCategory,
      subCategory,
      uom,
      marketPlace,
      documents,
      partSpecs,
      prices,
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
      metaTags,
      oem});

  PartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manufacturer = json['manufacturer'];
    gstItm = json['gst_itm'] != null ? GstItm.fromJson(json['gst_itm']) : null;
    partType = json['part_type'];
    partCategory = json['part_category'];
    subCategory = json['sub_category'];
    uom = json['uom'];
    // // if (json['market_place'] != null) {
    // //   marketPlace = <MarketPlace>[];
    // //   json['market_place'].forEach((v) {
    // //     marketPlace!.add(MarketPlace.fromJson(v));
    // //   });
    // // }
    // // if (json['documents'] != null) {
    // //   documents = <Documents>[];
    // //   json['documents'].forEach((v) {
    // //     documents!.add(Documents.fromJson(v));
    // //   });
    // // }
    // // if (json['part_specs'] != null) {
    // //   partSpecs = <PartSpecs>[];
    // //   json['part_specs'].forEach((v) {
    // //     partSpecs!.add(PartSpecs.fromJson(v));
    // //   });
    // // }
    // // if (json['prices'] != null) {
    // //   prices = <Prices>[];
    // //   json['prices'].forEach((v) {
    // //     prices!.add(Prices.fromJson(v));
    // //   });
    // // }
    // created = json['created'];
    // modified = json['modified'];
    // internalPartNo = json['internal_part_no'];
    partNumber = json['part_number'];
    // customerPartNumber = json['customer_part_number'];
    // bom = json['bom'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    mrp = json['mrp'];
    weight = json['weight'];
    length = json['length'];
    breadth = json['breadth'];
    height = json['height'];
    // serialization = json['serialization'];
    // oemSpecific = json['oem_specific'];
    // isActive = json['is_active'];
    // warrantyPeriod = json['warranty_period'];
    // warrantyTerms = json['warranty_terms'];
    // packingCharge = json['packing_charge'];
    // metaTags = json['meta_tags'].cast<int>();
    // oem = json['oem'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['manufacturer'] = manufacturer;
    if (gstItm != null) {
      data['gst_itm'] = gstItm!.toJson();
    }
    data['part_type'] = partType;
    data['part_category'] = partCategory;
    data['sub_category'] = subCategory;
    data['uom'] = uom;
    if (marketPlace != null) {
      data['market_place'] = marketPlace!.map((v) => v.toJson()).toList();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    if (partSpecs != null) {
      data['part_specs'] = partSpecs!.map((v) => v.toJson()).toList();
    }
    if (prices != null) {
      data['prices'] = prices!.map((v) => v.toJson()).toList();
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
    data['meta_tags'] = metaTags;
    data['oem'] = oem;
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
  CountryCode? countryCode;

  CountryGst({id, gstPercent, countryCode});

  CountryGst.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gstPercent = json['gst_percent'];
    countryCode = json['country_code'] != null
        ? CountryCode.fromJson(json['country_code'])
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

class CountryCode {
  String? id;
  String? name;

  CountryCode({id, name});

  CountryCode.fromJson(Map<String, dynamic> json) {
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

class MarketPlace {
  String? id;
  String? marketplaceName;

  MarketPlace({id, marketplaceName});

  MarketPlace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    marketplaceName = json['marketplace_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['marketplace_name'] = marketplaceName;
    return data;
  }
}

class Documents {
  String? id;
  String? name;
  Attachment? attachment;

  Documents({id, name, attachment});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    attachment = json['attachment'] != null
        ? Attachment.fromJson(json['attachment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (attachment != null) {
      data['attachment'] = attachment!.toJson();
    }
    return data;
  }
}

class Attachment {
  String? mediaType;
  String? attachment;
  String? name;
  bool? status;

  Attachment({mediaType, attachment, name, status});

  Attachment.fromJson(Map<String, dynamic> json) {
    mediaType = json['media_type'];
    attachment = json['attachment'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_type'] = mediaType;
    data['attachment'] = attachment;
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}

class PartSpecs {
  int? id;
  String? name;
  ProdSpec? prodSpec;

  PartSpecs({id, name, prodSpec});

  PartSpecs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    prodSpec =
        json['prod_spec'] != null ? ProdSpec.fromJson(json['prod_spec']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (prodSpec != null) {
      data['prod_spec'] = prodSpec!.toJson();
    }
    return data;
  }
}

class ProdSpec {
  int? id;
  String? created;
  String? modified;
  String? name;
  String? unit;

  ProdSpec({id, created, modified, name, unit});

  ProdSpec.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    name = json['name'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['name'] = name;
    data['unit'] = unit;
    return data;
  }
}

class Prices {
  String? id;
  String? created;
  String? modified;
  bool? isActive;
  int? price;
  int? minQuantity;
  int? maxQuantity;
  String? discount;
  String? partId;

  Prices(
      {id,
      created,
      modified,
      isActive,
      price,
      minQuantity,
      maxQuantity,
      discount,
      partId});

  Prices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    isActive = json['is_active'];
    price = json['price'];
    minQuantity = json['min_quantity'];
    maxQuantity = json['max_quantity'];
    discount = json['discount'];
    partId = json['part_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['is_active'] = isActive;
    data['price'] = price;
    data['min_quantity'] = minQuantity;
    data['max_quantity'] = maxQuantity;
    data['discount'] = discount;
    data['part_id'] = partId;
    return data;
  }
}
