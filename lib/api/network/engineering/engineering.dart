import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/engineering/backlog/backlog_model.dart';
import 'package:wikitek/models/engineering/engineering_model.dart';
import 'package:wikitek/utility/constant.dart';

class EngineeringNetwork {
  static const String engineeringListUrl = "projects/get/projects/?org_id=";
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
    print(result);
    BacklogRes response = BacklogRes.fromJson(result);
    return response;
  }
}
