import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/lead/history/sales_history_model.dart';
import 'package:wikitek/models/lead/lead_model.dart';
import 'package:wikitek/models/lead/part/part_model.dart';
import 'package:wikitek/models/lead/part_add/part_add_model.dart';

class SalesLeadNetwork {
  static const String salesLeadUrl = "pipo/sales/lead/";
  static const String salesLeadUpdateUrl = "pipo/update/sales/lead/";
  static const String getLeadPartsUrl = "parts/parts/";
  static const String addSalesHistoryUrl = "pipo/create/lead/history/";

  static Future<dynamic> getSalesLead(prams) async {
    final result = await httpManager.get(url: salesLeadUrl, params: prams);
    SalesLeadRes leadRes = SalesLeadRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> updateSalesLead(prams, leadID) async {
    final result =
        await httpManager.put(url: "$salesLeadUpdateUrl$leadID/", data: prams);

    PartAddRes leadRes = PartAddRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> addSalesLead(prams, leadID) async {
    final result =
        await httpManager.put(url: "$salesLeadUpdateUrl$leadID/", data: prams);

    PartAddRes leadRes = PartAddRes.fromJson(result);

    return leadRes;
  }

  static Future<dynamic> getLeadParts() async {
    final result = await httpManager.get(
      url: getLeadPartsUrl,
    );
    PartLeadRes leadRes = PartLeadRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> addLeadHistory(params) async {
    print(params);
    final result = await httpManager.postWithSuccess(
        url: addSalesHistoryUrl, data: params);
    print(result);
    SalesHistoryRes leadRes = SalesHistoryRes.fromJson(result);
    return leadRes;
  }
}
