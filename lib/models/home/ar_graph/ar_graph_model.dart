class ARGraphRes {
  ArData? aTPLSLSKAMWEST2;
  ArData? aTPLSLSKAMWEST1;
  ArData? aTPLSLSKAMNORTH;
  ArData? aTPLSLSKAMSOUTH;

  ARGraphRes(
      {this.aTPLSLSKAMNORTH,
      this.aTPLSLSKAMSOUTH,
      this.aTPLSLSKAMWEST1,
      this.aTPLSLSKAMWEST2});

  ARGraphRes.fromJson(Map<String, dynamic> json) {
    aTPLSLSKAMSOUTH = json['ATPL_SLS_KAM_SOUTH'] != null
        ? ArData.fromJson(json['ATPL_SLS_KAM_SOUTH'])
        : null;

    aTPLSLSKAMNORTH = json['ATPL_SLS_KAM_NORTH'] != null
        ? ArData.fromJson(json['ATPL_SLS_KAM_NORTH'])
        : null;

    aTPLSLSKAMWEST2 = json['ATPL_SLS_KAM_WEST2'] != null
        ? ArData.fromJson(json['ATPL_SLS_KAM_WEST2'])
        : null;

    aTPLSLSKAMWEST1 = json['ATPL_SLS_KAM_WEST1'] != null
        ? ArData.fromJson(json['ATPL_SLS_KAM_WEST1'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (aTPLSLSKAMSOUTH != null) {
      data['ATPL_SLS_KAM_SOUTH'] = aTPLSLSKAMSOUTH!.toJson();
    }

    if (aTPLSLSKAMNORTH != null) {
      data['ATPL_SLS_KAM_NORTH'] = aTPLSLSKAMNORTH!.toJson();
    }

    if (aTPLSLSKAMWEST2 != null) {
      data['ATPL_SLS_KAM_WEST2'] = aTPLSLSKAMWEST2!.toJson();
    }

    if (aTPLSLSKAMWEST1 != null) {
      data['ATPL_SLS_KAM_WEST1'] = aTPLSLSKAMWEST1!.toJson();
    }

    return data;
  }
}

class ArData {
  dynamic overdue30Days;
  dynamic overdue15Days;
  dynamic overdueIn15Days;
  dynamic dueIn15Days;
  dynamic dueIn30Days;
  dynamic dueIn45Days;
  dynamic dueIn60Days;

  ArData(
      {overdue30Days,
      overdue15Days,
      overdueIn15Days,
      dueIn15Days,
      dueIn30Days,
      dueIn45Days,
      dueIn60Days});

  ArData.fromJson(Map<String, dynamic> json) {
    overdue30Days = json['overdue_>30_days'];
    overdue15Days = json['overdue_>15_days'];
    overdueIn15Days = json['overdue_<15_days'];
    dueIn15Days = json['due_in_15_days'];
    dueIn30Days = json['due_in_30_days'];
    dueIn45Days = json['due_in_45_days'];
    dueIn60Days = json['due_in_60_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['overdue_>30_days'] = overdue30Days;
    data['overdue_>15_days'] = overdue15Days;
    data['overdue_<15_days'] = overdueIn15Days;
    data['due_in_15_days'] = dueIn15Days;
    data['due_in_30_days'] = dueIn30Days;
    data['due_in_45_days'] = dueIn45Days;
    data['due_in_60_days'] = dueIn60Days;
    return data;
  }
}
