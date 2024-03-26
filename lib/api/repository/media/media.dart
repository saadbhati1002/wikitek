import 'package:wikitek/api/network/media/media.dart';

class MediaRepository {
  Future<dynamic> getMediaTypeApiCall() async {
    return await MediaNetwork.getMediaType();
  }

  Future<dynamic> getProjectMediaTypeApiCall() async {
    return await MediaNetwork.getProjectMediaType();
  }
}
