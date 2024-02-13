class MarketPlaceRes {
  int? count;
  List<MarketPlaceData>? results;

  MarketPlaceRes({count, next, previous, results});

  MarketPlaceRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <MarketPlaceData>[];
      json['results'].forEach((v) {
        results!.add(MarketPlaceData.fromJson(v));
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

class MarketPlaceData {
  String? id;
  String? marketplaceName;

  MarketPlaceData({id, marketplaceName});

  MarketPlaceData.fromJson(Map<String, dynamic> json) {
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
