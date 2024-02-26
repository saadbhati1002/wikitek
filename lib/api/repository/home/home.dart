import 'package:wikitek/api/network/home/home.dart';
import 'package:wikitek/utility/constant.dart';

class HomeRepository {
  Future<dynamic> getKpiApiCall({String? year, String? type}) async {
    final params = {
      "org": "0a055b26-ae15-40a9-8291-25427b94ebb3",
      // "org": AppConstant.userData!.org!.id!,
      "financial_year": year,
      "metric": type
    };
    return await HomeNetwork.getKpi(params);
  }
}
