import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/lead/document/upload_document_model.dart';
import 'package:wikitek/models/sales_order/add_part/add_part_model.dart';
import 'package:wikitek/models/sales_order/delivery_term/delivery_term_model.dart';
import 'package:wikitek/models/sales_order/payment_term/payment_term_model.dart';
import 'package:wikitek/models/sales_order/sales_order_model.dart';
import 'package:wikitek/models/sales_order/transportation_term/transportation_term_model.dart';

class SalesOrderNetwork {
  static const String salesOrderUrl = "pipo/so/order/";
  static const String salesOrderUpdateUrl = "pipo/update/sales/order/";
  static const String addSalesOrderDocumentUrl = "pipo/create/so/document/";
  static const String paymentTermUrl = "organizations/fetch/payment/term/";
  static const String addSalesOrderUrl = "pipo/create/sales/order/";
  static const String transportationTermUrl = "pipo/transportation-terms/list/";
  static const String deliveryTermUrl = "organizations/fetch/delivery/term/";

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

  static Future<dynamic> createSalesOrder(params) async {
    print(params);
    final result =
        await httpManager.postWithSuccess(url: addSalesOrderUrl, data: params);
    print(result);
    CommonRes leadRes = CommonRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> getPaymentTerm() async {
    final result = await httpManager.get(url: paymentTermUrl);
    PaymentTermRes leadRes = PaymentTermRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> getDeliveryTerm() async {
    final result = await httpManager.get(url: deliveryTermUrl);
    DeliveryTermRes leadRes = DeliveryTermRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> getTransportationTerm() async {
    final result = await httpManager.get(url: transportationTermUrl);
    TransportationTermRes leadRes = TransportationTermRes.fromJson(result);
    return leadRes;
  }
}
