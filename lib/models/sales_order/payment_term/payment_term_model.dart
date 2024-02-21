class PaymentTermRes {
  int? count;

  List<PaymentTermData>? results;

  PaymentTermRes({count, results});

  PaymentTermRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <PaymentTermData>[];
      json['results'].forEach((v) {
        results!.add(PaymentTermData.fromJson(v));
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

class PaymentTermData {
  int? id;
  String? term;

  PaymentTermData({id, term});

  PaymentTermData.fromJson(Map<String, dynamic> json) {
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
