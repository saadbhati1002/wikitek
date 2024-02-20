import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/user/user_model.dart';

class UserNetwork {
  static const String usersUrl = "users/get/user/?org";

  static Future<dynamic> getUsers() async {
    final result = await httpManager.get(url: usersUrl);
    UserListRes leadRes = UserListRes.fromJson(result);
    return leadRes;
  }
}
