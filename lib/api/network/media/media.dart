import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/media/media_model.dart';

class MediaNetwork {
  static const String mediaTypeUrl = "pipo/get/media-type/";

  static Future<dynamic> getMediaType() async {
    final result = await httpManager.get(url: mediaTypeUrl);
    MediaRes response = MediaRes.fromJson(result);
    return response;
  }
}
