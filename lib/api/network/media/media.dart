import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/media/media_model.dart';

class MediaNetwork {
  static const String mediaTypeUrl = "pipo/get/media-type/";
  static const String projectMediaTypeUrl = "projects/get/document-type/";

  static Future<dynamic> getMediaType() async {
    final result = await httpManager.get(url: mediaTypeUrl);
    MediaRes response = MediaRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getProjectMediaType() async {
    final result = await httpManager.get(url: projectMediaTypeUrl);
    MediaRes response = MediaRes.fromJson(result);
    return response;
  }
}
