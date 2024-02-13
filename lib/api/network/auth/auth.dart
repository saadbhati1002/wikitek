import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/auth/verify_otp_model.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/user_model.dart';

class AuthNetwork {
  static const String loginUrl = "accounts/login";
  static const String registerUrl = "users/new/create/user/";
  static const String verifyRegisterOTPUrl = "users/confirm-registration-otp/";
  static const String resetPasswordUrl = "users/reset/password/";
  static const String forgotPasswordUrl = "users/forgot/password/";
  static Future<dynamic> loginUser(prams) async {
    final result = await httpManager.post(url: loginUrl, data: prams);
    UserRes response = UserRes.fromJson(result);
    return response;
  }

  static Future<dynamic> registerUser(prams) async {
    final result =
        await httpManager.postWithSuccess(url: registerUrl, data: prams);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> verifyRegisterOTP(prams) async {
    final result =
        await httpManager.post(url: verifyRegisterOTPUrl, data: prams);
    OTPVerify response = OTPVerify.fromJson(result);
    return response;
  }

  static Future<dynamic> resetPassword(prams) async {
    final result =
        await httpManager.postWithSuccess(url: resetPasswordUrl, data: prams);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> forgotPassword(prams) async {
    final result =
        await httpManager.postWithSuccess(url: forgotPasswordUrl, data: prams);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
