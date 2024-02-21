class TransportationTermRes {
  int? count;

  List<TransportationData>? results;

  TransportationTermRes({count, results});

  TransportationTermRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <TransportationData>[];
      json['results'].forEach((v) {
        results!.add(TransportationData.fromJson(v));
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

class TransportationData {
  int? id;
  String? name;

  TransportationData({id, name});

  TransportationData.fromJson(Map<String, dynamic> json) {
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
