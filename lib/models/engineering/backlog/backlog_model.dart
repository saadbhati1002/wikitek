class BacklogRes {
  int? count;

  List<BacklogData>? results;

  BacklogRes({count, next, previous, results});

  BacklogRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <BacklogData>[];
      json['results'].forEach((v) {
        results!.add(BacklogData.fromJson(v));
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

class BacklogData {
  String? id;
  User? user;
  Project? project;
  String? created;
  String? modified;
  String? backlogId;
  String? projectDesc;
  int? priority;
  String? userStory;
  String? targetDate;
  String? remark;
  String? status;

  BacklogData(
      {id,
      user,
      project,
      created,
      modified,
      backlogId,
      projectDesc,
      priority,
      userStory,
      targetDate,
      remark,
      status});

  BacklogData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
    created = json['created'];
    modified = json['modified'];
    backlogId = json['backlog_id'];
    projectDesc = json['project_desc'];
    priority = json['priority'];
    userStory = json['user_story'];
    targetDate = json['target_date'];
    remark = json['remark'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (project != null) {
      data['project'] = project!.toJson();
    }
    data['created'] = created;
    data['modified'] = modified;
    data['backlog_id'] = backlogId;
    data['project_desc'] = projectDesc;
    data['priority'] = priority;
    data['user_story'] = userStory;
    data['target_date'] = targetDate;
    data['remark'] = remark;
    data['status'] = status;
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;

  User({id, firstName, lastName, mobile, email});

  User.fromJson(Map<String, dynamic> json) {
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

class Project {
  String? id;
  String? projectName;
  String? client;

  Project({id, projectName, client});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    client = json['client'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    data['client'] = client;
    return data;
  }
}
