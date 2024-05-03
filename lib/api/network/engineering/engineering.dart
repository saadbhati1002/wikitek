import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/engineering/backlog/backlog_model.dart';
import 'package:wikitek/models/engineering/engineering_model.dart';
import 'package:wikitek/models/lead/document/upload_document_model.dart';
import 'package:wikitek/models/time_sheet/time_sheet_model.dart';
import 'package:wikitek/utility/constant.dart';

class EngineeringNetwork {
  static const String engineeringListUrl = "projects/get/projects/?org_id=";
  static const String projectCreateUrl = "projects/create/project/";
  static const String addEngineeringDocumentListUrl =
      "projects/create/document/";
  static const String engineeringBackLogUrl =
      "projects/get/project/backlog/?project_id=";
  static const String backlogCreateUrl = "projects/create/backlog/";
  static const String timeSheetCreateUrl = "employee_timesheet/new/";
  static String timeSheetUrl =
      "employee_timesheet/emp-timesheet/?user=${AppConstant.userData!.userId}";
  static const String updateTimeSheetUrl = "employee_timesheet/";

  static Future<dynamic> getEngineeringList() async {
    final result = await httpManager.get(
      url: "$engineeringListUrl${AppConstant.userData!.org!.id}",
    );
    EngineeringRes response = EngineeringRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getEngineeringBackLog({String? engineeringID}) async {
    final result = await httpManager.get(
      url: "$engineeringBackLogUrl$engineeringID",
    );

    BacklogRes response = BacklogRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addEngineeringDocument(params) async {
    final result = await httpManager.postWithoutJson(
        url: addEngineeringDocumentListUrl, data: params);

    SalesLeadDocumentUploadRes leadRes =
        SalesLeadDocumentUploadRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> addProject(params) async {
    final result =
        await httpManager.postWithSuccess(url: projectCreateUrl, data: params);

    CommonRes leadRes = CommonRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> addBacklog(params) async {
    final result =
        await httpManager.postWithSuccess(url: backlogCreateUrl, data: params);

    CommonRes leadRes = CommonRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> addTimeSheet(params) async {
    final result = await httpManager.postWithSuccess(
        url: timeSheetCreateUrl, data: params);

    CommonRes leadRes = CommonRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> getUserTimeSheet() async {
    final result = await httpManager.get(
      url: timeSheetUrl,
    );

    TimeSheetRes leadRes = TimeSheetRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> updateTimeSheet(params, timeSheetID) async {
    print("$updateTimeSheetUrl$timeSheetID/update/");
    print(params);
    final result = await httpManager.put(
        url: "$updateTimeSheetUrl$timeSheetID/update/", data: params);
    print(result);
    CommonRes leadRes = CommonRes.fromJson(result);
    return leadRes;
  }
}
