import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/department/department_model.dart';

class DepartmentNetwork {
  static const String departmentUrl = "organizations/fetch/department/";

  static Future<dynamic> getDepartment(param) async {
    final result = await httpManager.get(url: departmentUrl, params: param);

    DepartmentRes leadRes = DepartmentRes.fromJson(result);
    return leadRes;
  }
}
