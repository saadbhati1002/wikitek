import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/home/ar_graph/ar_graph_model.dart';
import 'package:wikitek/models/home/kpi/kpi_model.dart';

class HomeNetwork {
  static const String kpiUrl = "pipo/kpi/list/";
  static const String arGraphUrl = "invoices/accounts-receivable/?start_year=";

  static Future<dynamic> getKpi(prams) async {
    final result = await httpManager.get(url: kpiUrl, params: prams);

    KpiRes leadRes = KpiRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> getArGraphData(
      String? startYear, String? endYear) async {
    print("$arGraphUrl$startYear&end_year=$endYear");
    final result =
        await httpManager.get(url: "$arGraphUrl$startYear&end_year=$endYear");
    print(result);
    ARGraphRes leadRes = ARGraphRes.fromJson(result);
    return leadRes;
  }
}
