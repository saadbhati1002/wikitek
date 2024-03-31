import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wikitek/api/network/engineering/engineering.dart';
import 'package:wikitek/utility/constant.dart';

class EngineeringRepository {
  Future<dynamic> getEngineeringListApiCall() async {
    return await EngineeringNetwork.getEngineeringList();
  }

  Future<dynamic> getEngineeringBacklogApiCall(
      {String? engineeringBacklog}) async {
    return await EngineeringNetwork.getEngineeringBackLog(
        engineeringID: engineeringBacklog);
  }

  Future<dynamic> addSalesLeadDocumentApiCall(
      {File? selectedFile, String? engineeringID, String? mediaType}) async {
    String fileName = selectedFile!.path.split('/').last;

    var params = FormData.fromMap({
      "project": engineeringID,
      "document_type": mediaType,
      "name": fileName,
      "attachment":
          await MultipartFile.fromFile(selectedFile.path, filename: fileName),
    });
    return await EngineeringNetwork.addEngineeringDocument(params);
  }

  Future<dynamic> createProjectApiCall({
    String? projectName,
    String? projectBudget,
    String? projectCurrency,
    bool? saleable,
    String? description,
    String? status,
    String? salesOrderID,
    String? projectManagerID,
    String? clientID,
  }) async {
    final param = {
      "project_name": projectName,
      "project_budget": projectBudget,
      "budget_currency": projectCurrency,
      "saleable": saleable,
      "description": description,
      "status": status!.toLowerCase(),
      "org": AppConstant.userData!.org!.id,
      "project_manager": projectManagerID,
      "so": salesOrderID,
      "created_by": AppConstant.userData!.userId,
      "client": clientID,
      "sub_org": ""
    };
    return await EngineeringNetwork.addProject(param);
  }

  Future<dynamic> createBacklogApiCall(
      {String? backlogTitle,
      String? priority,
      String? targetDate,
      String? remark,
      String? status,
      String? projectID,
      String? description}) async {
    final param = {
      "project_desc": description,
      "priority": priority,
      "user_story": backlogTitle,
      "target_date": targetDate,
      "remark": remark,
      "status": status,
      "project": projectID,
      "user": AppConstant.userData!.userId
    };
    return await EngineeringNetwork.addBacklog(param);
  }

  Future<dynamic> createTimeSheetApiCall({
    String? projectID,
    String? backlogID,
    String? monday,
    String? tuesday,
    String? wednesday,
    String? thursday,
    String? friday,
    String? saturday,
    String? sunday,
    String? week,
  }) async {
    final params = {
      "project": projectID,
      "task": null,
      "user": AppConstant.userData!.userId,
      "week": week,
      "mon": monday,
      "tue": tuesday,
      "wed": wednesday,
      "thu": thursday,
      "fri": friday,
      "sat": saturday,
      "sun": sunday
    };
    return await EngineeringNetwork.addTimeSheet(params);
  }
}
