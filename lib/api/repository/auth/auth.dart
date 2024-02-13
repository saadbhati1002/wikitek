import 'package:wikitek/api/network/auth/auth.dart';

class AuthRepository {
  Future<dynamic> loginUserApiCall({String? email, String? password}) async {
    final params = {"username": email, "password": password};
    return await AuthNetwork.loginUser(params);
  }

  Future<dynamic> registerUserApiCall(
      {String? email,
      String? password,
      String? firstName,
      String? lastName,
      String? mobileNumber,
      String? organization,
      String? marketPlace}) async {
    final params = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "org": organization,
      "market_place": marketPlace,
      "password": password,
      "mobile": mobileNumber
    };
    return await AuthNetwork.registerUser(params);
  }

  Future<dynamic> verifyRegisterEmailApiCall(
      {String? email, String? otp}) async {
    final params = {"email": email, "otp": otp};
    return await AuthNetwork.verifyRegisterOTP(params);
  }

  Future<dynamic> forgotPasswordApiCall({
    String? email,
  }) async {
    final params = {
      "email": email,
    };
    return await AuthNetwork.forgotPassword(params);
  }
}
