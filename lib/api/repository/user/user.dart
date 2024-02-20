import 'package:wikitek/api/network/user/user.dart';

class UserRepository {
  Future<dynamic> userApiCall() async {
    return await UserNetwork.getUsers();
  }
}
