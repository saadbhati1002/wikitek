class TimeSheetRes {
  int? count;
  List<TimeSheetData>? results;

  TimeSheetRes({count, results});

  TimeSheetRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <TimeSheetData>[];
      json['results'].forEach((v) {
        results!.add(TimeSheetData.fromJson(v));
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

class TimeSheetData {
  String? id;
  String? task;
  dynamic year;
  dynamic week;
  Project? project;
  User? user;
  dynamic mon;
  dynamic tue;
  dynamic wed;
  dynamic thu;
  dynamic fri;
  dynamic sat;
  dynamic sun;

  TimeSheetData(
      {id, task, year, week, project, user, mon, tue, wed, thu, fri, sat, sun});

  TimeSheetData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'];
    year = json['year'];
    week = json['week'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thu = json['thu'];
    fri = json['fri'];
    sat = json['sat'];
    sun = json['sun'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task'] = task;
    data['year'] = year;
    data['week'] = week;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['mon'] = mon;
    data['tue'] = tue;
    data['wed'] = wed;
    data['thu'] = thu;
    data['fri'] = fri;
    data['sat'] = sat;
    data['sun'] = sun;
    return data;
  }
}

class Project {
  String? id;
  String? projectName;
  List<BacklogProject>? backlogProject;

  Project({id, projectName, backlogProject});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    if (json['backlog_project'] != null) {
      backlogProject = <BacklogProject>[];
      json['backlog_project'].forEach((v) {
        backlogProject!.add(BacklogProject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    if (backlogProject != null) {
      data['backlog_project'] = backlogProject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BacklogProject {
  String? id;
  String? backlogId;

  BacklogProject({id, backlogId});

  BacklogProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    backlogId = json['backlog_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['backlog_id'] = backlogId;
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? reportingManager;

  User({id, firstName, lastName, mobile, email, reportingManager});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    reportingManager = json['reporting_manager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['reporting_manager'] = reportingManager;
    return data;
  }
}
