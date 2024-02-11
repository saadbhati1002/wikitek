import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/user_model.dart';

class AuthNetwork {
  static const String loginUrl = "accounts/login";
  static const String forgotPasswordUrl = "users/forgot/password/";
  static Future<dynamic> loginUser(prams) async {
    final result = await httpManager.post(url: loginUrl, data: prams);
    UserRes loginRes = UserRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> forgotPassword(prams) async {
    final result =
        await httpManager.postWithSuccess(url: forgotPasswordUrl, data: prams);
    print(result);
    CommonRes loginRes = CommonRes.fromJson(result);
    return loginRes;
  }
}
