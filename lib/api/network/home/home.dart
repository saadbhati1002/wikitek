import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/home/kpi/kpi_model.dart';

class HomeNetwork {
  static const String kpiUrl = "pipo/kpi/list/";

  static Future<dynamic> getKpi(prams) async {
    final result = await httpManager.get(url: kpiUrl, params: prams);

    KpiRes leadRes = KpiRes.fromJson(result);
    return leadRes;
  }
}
