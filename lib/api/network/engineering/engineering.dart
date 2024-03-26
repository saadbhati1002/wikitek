import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/engineering/backlog/backlog_model.dart';
import 'package:wikitek/models/engineering/engineering_model.dart';
import 'package:wikitek/models/lead/document/upload_document_model.dart';
import 'package:wikitek/utility/constant.dart';

class EngineeringNetwork {
  static const String engineeringListUrl = "projects/get/projects/?org_id=";
  static const String projectCreateUrl = "projects/create/project/";
  static const String addEngineeringDocumentListUrl =
      "projects/create/document/";
  static const String engineeringBackLogUrl =
      "projects/get/project/backlog/?project_id=";
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
    print(params);
    final result =
        await httpManager.postWithSuccess(url: projectCreateUrl, data: params);
    print(result);
    CommonRes leadRes = CommonRes.fromJson(result);
    return leadRes;
  }
}
