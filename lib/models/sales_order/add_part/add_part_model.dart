class SalesOrderPartAddRes {
  bool? success;
  List<OrderPart> parts = [];
  SalesOrderPartAddRes({success, data});

  SalesOrderPartAddRes.fromJson(Map<String, dynamic> json) {
    if (json['parts'] != null) {
      List<OrderPart>? parts;
      parts = <OrderPart>[];
      json['parts'].forEach((v) {
        parts!.add(OrderPart.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    if (parts.isNotEmpty) {
      dataResponse['parts'] = parts.map((v) => v.toJson()).toList();
    }
    dataResponse['success'] = success;
    return dataResponse;
  }
}

class OrderPart {
  String? partsId;
  String? shortDescription;
  int? quantity;
  String? partsNo;
  int? price;
  String? gst;
  String? netPrice;
  String? extdGrossPrice;

  OrderPart(
      {partsId,
      shortDescription,
      quantity,
      partsNo,
      price,
      gst,
      netPrice,
      extdGrossPrice});

  OrderPart.fromJson(Map<String, dynamic> json) {
    partsId = json['parts_id'];
    shortDescription = json['short_description'];
    quantity = json['quantity'];
    partsNo = json['parts_no'];
    price = json['price'];
    gst = json['gst'];
    netPrice = json['net_price'];
    extdGrossPrice = json['extd_gross_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parts_id'] = partsId;
    data['short_description'] = shortDescription;
    data['quantity'] = quantity;
    data['parts_no'] = partsNo;
    data['price'] = price;
    data['gst'] = gst;
    data['net_price'] = netPrice;
    data['extd_gross_price'] = extdGrossPrice;
    return data;
  }
}
