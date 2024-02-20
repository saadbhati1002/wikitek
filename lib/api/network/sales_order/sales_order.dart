import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/lead/document/upload_document_model.dart';
import 'package:wikitek/models/sales_order/add_part/add_part_model.dart';
import 'package:wikitek/models/sales_order/sales_order_model.dart';

class SalesOrderNetwork {
  static const String salesOrderUrl = "pipo/so/order/";
  static const String salesOrderUpdateUrl = "pipo/update/sales/order/";
  static const String addSalesOrderDocumentUrl = "pipo/create/so/document/";

  static Future<dynamic> getSalesOrder(prams) async {
    final result = await httpManager.get(url: salesOrderUrl, params: prams);
    SalesOrderRes leadRes = SalesOrderRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> updateSalesOrder(prams, leadID) async {
    final result =
        await httpManager.put(url: "$salesOrderUpdateUrl$leadID/", data: prams);

    SalesOrderPartAddRes leadRes = SalesOrderPartAddRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> salesOrderAdd(prams, leadID) async {
    final result =
        await httpManager.put(url: "$salesOrderUpdateUrl$leadID/", data: prams);

    SalesOrderPartAddRes leadRes = SalesOrderPartAddRes.fromJson(result);

    return leadRes;
  }

  static Future<dynamic> addSalesLeadDocument(params) async {
    final result = await httpManager.postWithoutJson(
        url: addSalesOrderDocumentUrl, data: params);

    SalesLeadDocumentUploadRes leadRes =
        SalesLeadDocumentUploadRes.fromJson(result);
    return leadRes;
  }
}
