import 'package:wikitek/api/network/engineering/engineering.dart';

class EngineeringRepository {
  Future<dynamic> getEngineeringListApiCall() async {
    return await EngineeringNetwork.getEngineeringList();
  }

  Future<dynamic> getEngineeringBacklogApiCall(
      {String? engineeringBacklog}) async {
    return await EngineeringNetwork.getEngineeringBackLog(
        engineeringID: engineeringBacklog);
  }
}
