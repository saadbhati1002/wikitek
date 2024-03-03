import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/attendance/attendance_model.dart';
import 'package:wikitek/models/attendance/org_holiday/org_holiday_model.dart';
import 'package:wikitek/models/attendance/org_user_model/org_user_model.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/utility/constant.dart';

class AttendanceNetwork {
  static const String applyLeaveUrl = "org/create/leave-appln/";
  static const String getAttendanceUrl = "org/get/ownleavestatus/?user_id=";
  static const String getOrgUserUrl = "users/get/user/?org=";
  static const String getOrgHolidayUrl = "org/get/holidaylist/?org_id=";
  static Future<dynamic> getAttendance() async {
    final result = await httpManager.get(
      url: "$getAttendanceUrl${AppConstant.userData!.userId!}",
    );

    AttendanceRes response = AttendanceRes.fromJson(result);
    return response;
  }

  static Future<dynamic> applyForLeave(params) async {
    final result =
        await httpManager.postWithSuccess(url: applyLeaveUrl, data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getOrgUser() async {
    print("$getOrgUserUrl${AppConstant.userData!.org!.companyName}");
    final result = await httpManager.get(
      url: "$getOrgUserUrl${AppConstant.userData!.org!.companyName}",
    );
    print(result);
    OrgUserRes response = OrgUserRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getOrgHoliday() async {
    final result = await httpManager.get(
      url: "$getOrgHolidayUrl${AppConstant.userData!.org!.id}",
    );

    OrgHolidayRes response = OrgHolidayRes.fromJson(result);
    return response;
  }
}
