import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/common_model.dart';

class AttendanceNetwork {
  static const String applyLeaveUrl = "org/create/leave-appln/";

  static Future<dynamic> applyForLeave(params) async {
    print(params);
    final result =
        await httpManager.postWithSuccess(url: applyLeaveUrl, data: params);
    print(result);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
