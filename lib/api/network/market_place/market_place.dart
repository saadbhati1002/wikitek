import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/market_place/market_place_model.dart';

class MarketPlaceNetwork {
  static const String marketPlaceUrl = "parts/get/marketplace/";

  static Future<dynamic> getMarketPlace() async {
    final result = await httpManager.get(url: marketPlaceUrl);
    MarketPlaceRes leadRes = MarketPlaceRes.fromJson(result);
    return leadRes;
  }
}
