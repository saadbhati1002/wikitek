import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/lead/lead_model.dart';

class SalesLeadNetwork {
  static const String salesLeadUrl = "pipo/sales/lead/";

  static Future<dynamic> getSalesLead(prams) async {
    print(prams);
    final result = await httpManager.get(url: salesLeadUrl, params: prams);
    print(result);
    SalesLeadRes leadRes = SalesLeadRes.fromJson(result);
    return leadRes;
  }
}
