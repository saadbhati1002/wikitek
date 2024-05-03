import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/lead/document/upload_document_model.dart';
import 'package:wikitek/models/lead/history/sales_history_model.dart';
import 'package:wikitek/models/lead/lead_model.dart';
import 'package:wikitek/models/lead/part/part_model.dart';
import 'package:wikitek/models/lead/part_add/part_add_model.dart';

class SalesLeadNetwork {
  static const String salesLeadUrl = "pipo/sales/lead/";
  static const String salesLeadUpdateUrl = "pipo/update/sales/lead/";
  static const String getLeadPartsUrl = "parts/parts/";
  static const String addSalesHistoryUrl = "pipo/create/lead/history/";
  static const String addMainSalesLeadUrl = "pipo/create/sales/lead/";
  static const String addSalesLeadDocumentUrl =
      "pipo/create/sales-lead/document/";

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
    print(prams);
    final result =
        await httpManager.put(url: "$salesLeadUpdateUrl$leadID/", data: prams);
    print("lead added");
    print(result);
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
    final result = await httpManager.postWithSuccess(
        url: addSalesHistoryUrl, data: params);

    SalesHistoryRes leadRes = SalesHistoryRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> addSalesLeadDocument(params) async {
    final result = await httpManager.postWithoutJson(
        url: addSalesLeadDocumentUrl, data: params);

    SalesLeadDocumentUploadRes leadRes =
        SalesLeadDocumentUploadRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> addMainSalesLead(params) async {
    final result = await httpManager.postWithSuccess(
        url: addMainSalesLeadUrl, data: params);
    print(result);
    CommonRes leadRes = CommonRes.fromJson(result);
    return leadRes;
  }
}
