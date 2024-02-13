import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/lead/lead_model.dart';

class SalesLeadNetwork {
  static const String salesLeadUrl = "pipo/sales/lead/";
  static const String salesLeadUpdateUrl = "pipo/update/sales/lead/";

  static Future<dynamic> getSalesLead(prams) async {
    final result = await httpManager.get(url: salesLeadUrl, params: prams);
    SalesLeadRes leadRes = SalesLeadRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> updateSalesLead(prams, leadID) async {
    print("$salesLeadUpdateUrl$leadID/");
    final result =
        await httpManager.put(url: "$salesLeadUpdateUrl$leadID/", data: prams);
    CommonRes leadRes = CommonRes.fromJson(result);
    return leadRes;
  }
}
