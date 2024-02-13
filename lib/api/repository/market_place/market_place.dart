import 'package:wikitek/api/network/market_place/market_place.dart';

class MarketPlaceRepository {
  Future<dynamic> marketPlaceApiCall() async {
    return await MarketPlaceNetwork.getMarketPlace();
  }
}
