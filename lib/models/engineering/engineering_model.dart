class EngineeringRes {
  int? count;

  List<EngineeringData>? results;

  EngineeringRes({count, results});

  EngineeringRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <EngineeringData>[];
      json['results'].forEach((v) {
        results!.add(EngineeringData.fromJson(v));
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

class EngineeringData {
  String? id;
  List<Tasks>? tasks;
  List<Documents>? documents;
  // List<Null>? comments;
  String? createdBy;
  ProjectManager? projectManager;
  Client? client;
  SubOrg? subOrg;
  So? so;
  Client? org;
  String? created;
  String? modified;
  String? projectName;
  String? projectId;
  dynamic projectBudget;
  String? budgetCurrency;
  bool? saleable;
  String? description;
  String? status;

  EngineeringData({
    id,
    tasks,
    documents,
    comments,
    createdBy,
    projectManager,
    client,
    subOrg,
    so,
    org,
    created,
    modified,
    projectName,
    projectId,
    projectBudget,
    budgetCurrency,
    saleable,
    description,
    status,
  });

  EngineeringData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
    // if (json['comments'] != null) {
    //   comments = <Null>[];
    //   json['comments'].forEach((v) {
    //     comments!.add(new Null.fromJson(v));
    //   });
    // }
    createdBy = json['created_by'];
    projectManager = json['project_manager'] != null
        ? ProjectManager.fromJson(json['project_manager'])
        : null;
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    subOrg = json['sub_org'] != null ? SubOrg.fromJson(json['sub_org']) : null;
    so = json['so'] != null ? So.fromJson(json['so']) : null;
    org = json['org'] != null ? Client.fromJson(json['org']) : null;
    created = json['created'];
    modified = json['modified'];
    projectName = json['project_name'];
    projectId = json['project_id'];
    projectBudget = json['project_budget'];
    budgetCurrency = json['budget_currency'];
    saleable = json['saleable'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    // if (comments != null) {
    //   data['comments'] = comments!.map((v) => v.toJson()).toList();
    // }
    data['created_by'] = createdBy;
    if (projectManager != null) {
      data['project_manager'] = projectManager!.toJson();
    }
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (subOrg != null) {
      data['sub_org'] = subOrg!.toJson();
    }
    if (so != null) {
      data['so'] = so!.toJson();
    }
    if (org != null) {
      data['org'] = org!.toJson();
    }
    data['created'] = created;
    data['modified'] = modified;
    data['project_name'] = projectName;
    data['project_id'] = projectId;
    data['project_budget'] = projectBudget;
    data['budget_currency'] = budgetCurrency;
    data['saleable'] = saleable;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}

class Tasks {
  String? id;
  String? created;
  String? modified;
  String? name;
  String? taskType;
  String? slug;
  String? code;
  String? description;
  String? taskDate;
  String? startTime;
  String? endTime;
  String? status;
  String? project;

  Tasks(
      {id,
      created,
      modified,
      name,
      taskType,
      slug,
      code,
      description,
      taskDate,
      startTime,
      endTime,
      status,
      project});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    name = json['name'];
    taskType = json['task_type'];
    slug = json['slug'];
    code = json['code'];
    description = json['description'];
    taskDate = json['task_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    project = json['project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['name'] = name;
    data['task_type'] = taskType;
    data['slug'] = slug;
    data['code'] = code;
    data['description'] = description;
    data['task_date'] = taskDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['project'] = project;
    return data;
  }
}

class Documents {
  String? id;
  String? documentType;
  String? created;
  String? modified;
  String? name;
  String? attachment;
  String? project;

  Documents({id, documentType, created, modified, name, attachment, project});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentType = json['document_type'];
    created = json['created'];
    modified = json['modified'];
    name = json['name'];
    attachment = json['attachment'];
    project = json['project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['document_type'] = documentType;
    data['created'] = created;
    data['modified'] = modified;
    data['name'] = name;
    data['attachment'] = attachment;
    data['project'] = project;
    return data;
  }
}

class ProjectManager {
  String? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;

  ProjectManager({id, firstName, lastName, mobile, email});

  ProjectManager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}

class Client {
  String? id;
  String? companyName;
  bool isSelected = false;
  Client({id, companyName});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    return data;
  }
}

class SubOrg {
  String? id;
  String? created;
  String? modified;
  String? orgCode;
  String? subCompanyName;
  String? org;
  String? contactPerson;

  SubOrg({id, created, modified, orgCode, subCompanyName, org, contactPerson});

  SubOrg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    orgCode = json['org_code'];
    subCompanyName = json['sub_company_name'];
    org = json['org'];
    contactPerson = json['contact_person'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['org_code'] = orgCode;
    data['sub_company_name'] = subCompanyName;
    data['org'] = org;
    data['contact_person'] = contactPerson;
    return data;
  }
}

class So {
  String? id;
  String? soId;

  So({id, soId});

  So.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soId = json['so_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['so_id'] = soId;
    return data;
  }
}

class StatusModel {
  String? status;
  bool? isSelected = false;
  StatusModel({this.isSelected, this.status});
}
