import 'package:wikitek/api/network/home/home.dart';
import 'package:wikitek/utility/constant.dart';

class HomeRepository {
  Future<dynamic> getKpiApiCall({String? year, String? type}) async {
    final params = {
      "org": AppConstant.userData!.org!.id!,
      "financial_year": year,
      "metric": type
    };
    return await HomeNetwork.getKpi(params);
  }
}
