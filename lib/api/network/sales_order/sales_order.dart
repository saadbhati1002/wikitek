import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/common_model.dart';
import 'package:wikitek/models/lead/document/upload_document_model.dart';
import 'package:wikitek/models/sales_order/add_part/add_part_model.dart';
import 'package:wikitek/models/sales_order/address/address_model.dart';
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
  static const String addressUrl = "organizations/fetch/org/address/";

  static Future<dynamic> getSalesOrder(prams) async {
    final result = await httpManager.get(url: salesOrderUrl, params: prams);
    SalesOrderRes leadRes = SalesOrderRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> updateSalesOrder(prams, leadID) async {
    final result =
        await httpManager.put(url: "$salesOrderUpdateUrl$leadID/", data: prams);

    SalesOrderPartAddRes response = SalesOrderPartAddRes.fromJson(result);
    return response;
  }

  static Future<dynamic> salesOrderAdd(prams, leadID) async {
    final result =
        await httpManager.put(url: "$salesOrderUpdateUrl$leadID/", data: prams);
    print(result);
    SalesOrderPartAddRes response = SalesOrderPartAddRes.fromJson(result);

    return response;
  }

  static Future<dynamic> addSalesLeadDocument(params) async {
    final result = await httpManager.postWithoutJson(
        url: addSalesOrderDocumentUrl, data: params);

    SalesLeadDocumentUploadRes response =
        SalesLeadDocumentUploadRes.fromJson(result);
    return response;
  }

  static Future<dynamic> createSalesOrder(params) async {
    final result =
        await httpManager.postWithSuccess(url: addSalesOrderUrl, data: params);
    print(result);
    CommonRes leadRes = CommonRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> getPaymentTerm() async {
    final result = await httpManager.get(url: paymentTermUrl);
    PaymentTermRes response = PaymentTermRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getDeliveryTerm() async {
    final result = await httpManager.get(url: deliveryTermUrl);
    DeliveryTermRes response = DeliveryTermRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getTransportationTerm() async {
    final result = await httpManager.get(url: transportationTermUrl);
    TransportationTermRes response = TransportationTermRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getAddress(prams) async {
    final result = await httpManager.get(url: addressUrl, params: prams);
    AddressRes response = AddressRes.fromJson(result);
    return response;
  }
}
