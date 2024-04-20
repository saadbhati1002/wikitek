class ARGraphRes {
  ASSOCIATE? aSSOCIATE;
  ASSOCIATE? wTKWHINMNGR;
  ASSOCIATE? wTKWHOUTMNGR;
  ASSOCIATE? wTKPRODMNGR;
  ASSOCIATE? wTKPRODMASS;
  ASSOCIATE? wTKSLSCHNLSOUTH;
  ASSOCIATE? wTKWHOUTASS;
  ASSOCIATE? wTKPRODASS;
  ASSOCIATE? wTKSLSKAMNORTH;
  ASSOCIATE? wTKSLSCHNLNORTH;
  ASSOCIATE? wTKSLSKAMWEST;
  ASSOCIATE? wTKINASS;
  ASSOCIATE? wTKENGGEMP;
  ASSOCIATE? wTKSLSKAMSOUTH;
  ASSOCIATE? wTKSLSCHNLEAST;
  ASSOCIATE? wTKHRMNGR;
  ASSOCIATE? wTKPURASS;
  ASSOCIATE? wTKFINASS;
  ASSOCIATE? wTKPURMNGR;
  ASSOCIATE? wTKSLSCHNLWEST;

  ARGraphRes(
      {aSSOCIATE,
      wTKWHINMNGR,
      wTKWHOUTMNGR,
      wTKPRODMNGR,
      wTKPRODMASS,
      wTKSLSCHNLSOUTH,
      wTKWHOUTASS,
      wTKPRODASS,
      wTKSLSKAMNORTH,
      wTKSLSCHNLNORTH,
      wTKSLSKAMWEST,
      wTKINASS,
      wTKENGGEMP,
      wTKSLSKAMSOUTH,
      wTKSLSCHNLEAST,
      wTKHRMNGR,
      wTKPURASS,
      wTKFINASS,
      wTKPURMNGR,
      wTKSLSCHNLWEST});

  ARGraphRes.fromJson(Map<String, dynamic> json) {
    aSSOCIATE = json['ASSOCIATE'] != null
        ? ASSOCIATE.fromJson(json['ASSOCIATE'])
        : null;
    wTKWHINMNGR = json['WTK_WH_IN_MNGR'] != null
        ? ASSOCIATE.fromJson(json['WTK_WH_IN_MNGR'])
        : null;
    wTKWHOUTMNGR = json['WTK_WH_OUT_MNGR'] != null
        ? ASSOCIATE.fromJson(json['WTK_WH_OUT_MNGR'])
        : null;
    wTKPRODMNGR = json['WTK_PROD_MNGR'] != null
        ? ASSOCIATE.fromJson(json['WTK_PROD_MNGR'])
        : null;
    wTKPRODMASS = json['WTK_PRODM_ASS'] != null
        ? ASSOCIATE.fromJson(json['WTK_PRODM_ASS'])
        : null;
    wTKSLSCHNLSOUTH = json['WTK_SLS_CHNL_SOUTH'] != null
        ? ASSOCIATE.fromJson(json['WTK_SLS_CHNL_SOUTH'])
        : null;
    wTKWHOUTASS = json['WTK_WH_OUT_ASS'] != null
        ? ASSOCIATE.fromJson(json['WTK_WH_OUT_ASS'])
        : null;
    wTKPRODASS = json['WTK_PROD_ASS'] != null
        ? ASSOCIATE.fromJson(json['WTK_PROD_ASS'])
        : null;
    wTKSLSKAMNORTH = json['WTK_SLS_KAM_NORTH'] != null
        ? ASSOCIATE.fromJson(json['WTK_SLS_KAM_NORTH'])
        : null;
    wTKSLSCHNLNORTH = json['WTK_SLS_CHNL_NORTH'] != null
        ? ASSOCIATE.fromJson(json['WTK_SLS_CHNL_NORTH'])
        : null;
    wTKSLSKAMWEST = json['WTK_SLS_KAM_WEST'] != null
        ? ASSOCIATE.fromJson(json['WTK_SLS_KAM_WEST'])
        : null;
    wTKINASS = json['WTK_IN_ASS'] != null
        ? ASSOCIATE.fromJson(json['WTK_IN_ASS'])
        : null;
    wTKENGGEMP = json['WTK_ENGG_EMP'] != null
        ? ASSOCIATE.fromJson(json['WTK_ENGG_EMP'])
        : null;
    wTKSLSKAMSOUTH = json['WTK_SLS_KAM_SOUTH'] != null
        ? ASSOCIATE.fromJson(json['WTK_SLS_KAM_SOUTH'])
        : null;
    wTKSLSCHNLEAST = json['WTK_SLS_CHNL_EAST'] != null
        ? ASSOCIATE.fromJson(json['WTK_SLS_CHNL_EAST'])
        : null;
    wTKHRMNGR = json['WTK_HR_MNGR'] != null
        ? ASSOCIATE.fromJson(json['WTK_HR_MNGR'])
        : null;
    wTKPURASS = json['WTK_PUR_ASS'] != null
        ? ASSOCIATE.fromJson(json['WTK_PUR_ASS'])
        : null;
    wTKFINASS = json['WTK_FIN_ASS'] != null
        ? ASSOCIATE.fromJson(json['WTK_FIN_ASS'])
        : null;
    wTKPURMNGR = json['WTK_PUR_MNGR'] != null
        ? ASSOCIATE.fromJson(json['WTK_PUR_MNGR'])
        : null;
    wTKSLSCHNLWEST = json['WTK_SLS_CHNL_WEST'] != null
        ? ASSOCIATE.fromJson(json['WTK_SLS_CHNL_WEST'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (aSSOCIATE != null) {
      data['ASSOCIATE'] = aSSOCIATE!.toJson();
    }
    if (wTKWHINMNGR != null) {
      data['WTK_WH_IN_MNGR'] = wTKWHINMNGR!.toJson();
    }
    if (wTKWHOUTMNGR != null) {
      data['WTK_WH_OUT_MNGR'] = wTKWHOUTMNGR!.toJson();
    }
    if (wTKPRODMNGR != null) {
      data['WTK_PROD_MNGR'] = wTKPRODMNGR!.toJson();
    }
    if (wTKPRODMASS != null) {
      data['WTK_PRODM_ASS'] = wTKPRODMASS!.toJson();
    }
    if (wTKSLSCHNLSOUTH != null) {
      data['WTK_SLS_CHNL_SOUTH'] = wTKSLSCHNLSOUTH!.toJson();
    }
    if (wTKWHOUTASS != null) {
      data['WTK_WH_OUT_ASS'] = wTKWHOUTASS!.toJson();
    }
    if (wTKPRODASS != null) {
      data['WTK_PROD_ASS'] = wTKPRODASS!.toJson();
    }
    if (wTKSLSKAMNORTH != null) {
      data['WTK_SLS_KAM_NORTH'] = wTKSLSKAMNORTH!.toJson();
    }
    if (wTKSLSCHNLNORTH != null) {
      data['WTK_SLS_CHNL_NORTH'] = wTKSLSCHNLNORTH!.toJson();
    }
    if (wTKSLSKAMWEST != null) {
      data['WTK_SLS_KAM_WEST'] = wTKSLSKAMWEST!.toJson();
    }
    if (wTKINASS != null) {
      data['WTK_IN_ASS'] = wTKINASS!.toJson();
    }
    if (wTKENGGEMP != null) {
      data['WTK_ENGG_EMP'] = wTKENGGEMP!.toJson();
    }
    if (wTKSLSKAMSOUTH != null) {
      data['WTK_SLS_KAM_SOUTH'] = wTKSLSKAMSOUTH!.toJson();
    }
    if (wTKSLSCHNLEAST != null) {
      data['WTK_SLS_CHNL_EAST'] = wTKSLSCHNLEAST!.toJson();
    }
    if (wTKHRMNGR != null) {
      data['WTK_HR_MNGR'] = wTKHRMNGR!.toJson();
    }
    if (wTKPURASS != null) {
      data['WTK_PUR_ASS'] = wTKPURASS!.toJson();
    }
    if (wTKFINASS != null) {
      data['WTK_FIN_ASS'] = wTKFINASS!.toJson();
    }
    if (wTKPURMNGR != null) {
      data['WTK_PUR_MNGR'] = wTKPURMNGR!.toJson();
    }
    if (wTKSLSCHNLWEST != null) {
      data['WTK_SLS_CHNL_WEST'] = wTKSLSCHNLWEST!.toJson();
    }
    return data;
  }
}

class ASSOCIATE {
  int? overdue30Days;
  int? overdueIn15Days;
  int? overdue15Days;
  int? dueIn15Days;
  int? dueIn30Days;
  int? dueIn45Days;
  int? dueIn60Days;

  ASSOCIATE(
      {overdue30Days,
      overdueIn15Days,
      overdue15Days,
      dueIn15Days,
      dueIn30Days,
      dueIn45Days,
      dueIn60Days});

  ASSOCIATE.fromJson(Map<String, dynamic> json) {
    overdue30Days = json['overdue_>30_days'];
    overdueIn15Days = json['overdue_>15_days'];
    overdue15Days = json['overdue_<15_days'];
    dueIn15Days = json['due_in_15_days'];
    dueIn30Days = json['due_in_30_days'];
    dueIn45Days = json['due_in_45_days'];
    dueIn60Days = json['due_in_60_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['overdue_>30_days'] = overdue30Days;
    data['overdue_>15_days'] = overdueIn15Days;
    data['overdue_<15_days'] = overdue15Days;
    data['due_in_15_days'] = dueIn15Days;
    data['due_in_30_days'] = dueIn30Days;
    data['due_in_45_days'] = dueIn45Days;
    data['due_in_60_days'] = dueIn60Days;
    return data;
  }
}
