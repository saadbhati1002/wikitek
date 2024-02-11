import 'package:wikitek/api/network/auth/auth.dart';

class AuthRepository {
  Future<dynamic> loginUserApiCall({String? email, String? password}) async {
    final params = {"username": email, "password": password};
    return await AuthNetwork.loginUser(params);
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
