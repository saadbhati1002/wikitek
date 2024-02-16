import 'package:wikitek/api/network/department/department.dart';
import 'package:wikitek/utility/constant.dart';

class DepartmentRepository {
  Future<dynamic> departmentApiCall({String? roleID}) async {
    final params = {"org": AppConstant.userData!.org!.id!, "role_id": roleID};
    return await DepartmentNetwork.getDepartment(params);
  }
}
