import 'package:wikitek/api/network/attendance.dart/attendance.dart';
import 'package:wikitek/utility/constant.dart';

class AttendanceRepository {
  Future<dynamic> applyForLeaveApiCall(
      {String? leaveDate, String? leaveType, String? type}) async {
    final params = {
      "user": AppConstant.userData!.userId!,
      "leave_dates": [
        {
          "date": leaveDate,
          "leave_type": leaveType,
          "type": type,
          "status": "Applied"
        }
      ]
    };
    return await AttendanceNetwork.applyForLeave(params);
  }
}
