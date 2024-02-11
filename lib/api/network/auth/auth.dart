import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/user_model.dart';

class AuthNetwork {
  static const String loginUrl = "accounts/login";
  static Future<dynamic> loginUser(prams) async {
    final result = await httpManager.post(url: loginUrl, data: prams);

    UserRes loginRes = UserRes.fromJson(result);
    return loginRes;
  }
}
