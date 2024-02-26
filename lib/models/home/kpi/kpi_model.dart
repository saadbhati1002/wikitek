class KpiRes {
  int? count;
  List<KpiResData> results = [];

  KpiRes({count, results});

  KpiRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <KpiResData>[];
      json['results'].forEach((v) {
        results.add(KpiResData.fromJson(v));
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

class KpiResData {
  String? id;
  String? department;
  String? metric;
  String? created;
  String? modified;
  double? apr;
  double? may;
  double? jun;
  double? jul;
  double? aug;
  double? sep;
  double? oct;
  double? nov;
  double? dec;
  double? jan;
  double? feb;
  double? mar;
  String? financialYear;
  String? org;
  double? total;

  KpiResData(
      {id,
      department,
      metric,
      created,
      modified,
      apr,
      may,
      jun,
      jul,
      aug,
      sep,
      oct,
      nov,
      dec,
      jan,
      feb,
      mar,
      financialYear,
      org,
      subOrg});

  KpiResData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    department = json['department'];
    metric = json['metric'];
    created = json['created'];
    modified = json['modified'];
    apr = json['apr'] != null ? json['apr']! : 0.0;
    may = json['may'] != null ? json['may']! : 0.0;
    jun = json['jun'] != null ? json['jun']! : 0.0;
    jul = json['jul'] != null ? json['jul']! : 0.0;
    aug = json['aug'] != null ? json['aug']! : 0.0;
    sep = json['sep'] != null ? json['sep']! : 0.0;
    oct = json['oct'] != null ? json['oct']! : 0.0;
    nov = json['nov'] != null ? json['nov']! : 0.0;
    dec = json['dec'] != null ? json['dec']! : 0.0;
    jan = json['jan'] != null ? json['jan']! : 0.0;
    feb = json['feb'] != null ? json['feb']! : 0.0;
    mar = json['mar'] != null ? json['mar']! : 0.0;
    financialYear = json['financial_year'];
    org = json['org'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['department'] = department;
    data['metric'] = metric;
    data['created'] = created;
    data['modified'] = modified;
    data['apr'] = apr;
    data['may'] = may;
    data['jun'] = jun;
    data['jul'] = jul;
    data['aug'] = aug;
    data['sep'] = sep;
    data['oct'] = oct;
    data['nov'] = nov;
    data['dec'] = dec;
    data['jan'] = jan;
    data['feb'] = feb;
    data['mar'] = mar;
    data['financial_year'] = financialYear;
    data['org'] = org;

    return data;
  }
}
