class DeliveryTermRes {
  int? count;

  List<DeliveryTermData>? results;

  DeliveryTermRes({count, results});

  DeliveryTermRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <DeliveryTermData>[];
      json['results'].forEach((v) {
        results!.add(DeliveryTermData.fromJson(v));
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

class DeliveryTermData {
  int? id;
  String? term;

  DeliveryTermData({id, term});

  DeliveryTermData.fromJson(Map<String, dynamic> json) {
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
