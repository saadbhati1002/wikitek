class ARGraphRes {
  dynamic overdue30Days;
  dynamic overdue15Days;
  dynamic overdueIn15Days;
  dynamic dueIn15Days;
  dynamic dueIn30Days;
  dynamic dueIn45Days;
  dynamic dueIn60Days;

  ARGraphRes(
      {overdue30Days,
      overdue15Days,
      overdueIn15Days,
      dueIn15Days,
      dueIn30Days,
      dueIn45Days,
      dueIn60Days});

  ARGraphRes.fromJson(Map<String, dynamic> json) {
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
