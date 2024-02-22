import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wikitek/api/network/sales_order/sales_order.dart';
import 'package:wikitek/models/lead/part/part_model.dart';
import 'package:wikitek/models/sales_order/sales_order_model.dart';
import 'package:wikitek/utility/constant.dart';

class SalesOrderRepository {
  Future<dynamic> salesOrderApiCall({String? year}) async {
    final params = {
      "org": AppConstant.userData!.org!.id!,
      "financial_year": year
    };
    return await SalesOrderNetwork.getSalesOrder(params);
  }

  Future<dynamic> salesOrderUpdateApiCall(
      {SalesOrderData? data, int? index}) async {
    data!.parts.removeAt(index!);
    var part = jsonEncode(data.parts);
    final params = {
      "po_date": data.poDate,
      "description": data.description,
      "comments": data.comments,
      "ref_po": data.refPo,
      "expected_inv_date": data.expectedInvDate,
      "sales_lead": data.salesLead,
      "client": data.client?.id,
      "sub_org": null,
      "billing_address": data.billingAddress?.id,
      "shipping_address": data.shippingAddress?.id,
      "payment_term": data.paymentTerm?.id,
      "delivery_term": data.deliveryTerm?.id,
      "contact_to": data.contactTo?.id,
      "department": data.department?.id,
      "so_status": data.soStatus,
      "transportation_term": data.transportationTerm?.id,
      "org": data.org?.id,
      "parts": jsonDecode(part)
    };
    return await SalesOrderNetwork.updateSalesOrder(params, data.id);
  }

  Future<dynamic> addSalesOrderUpdateApiCall(
      {SalesOrderData? data, PartData? partData}) async {
    String gst = partData!.gstItm!.countryGst![0].gstPercent.toString();
    String shortDescription = partData.shortDescription.toString();
    int quantity = 1;
    var newMap = {
      "short_description": shortDescription,
      "quantity": quantity,
      "unit_cost": partData.mrp.toString(),
      "status": "Active",
      "gst": gst,
      "net_price": (partData.mrp! * quantity).toString(),
      "extd_gross_price": partData.calculatedPrice.toString(),
      "parts_no": partData.id,
      "parts_id": partData.id
    };

    var part = jsonEncode(data!.parts);
    List jsonEncodedMap = jsonDecode(part);
    jsonEncodedMap.add(newMap);

    final params = {
      "po_date": data.poDate,
      "description": data.description,
      "comments": data.comments,
      "ref_po": data.refPo,
      "expected_inv_date": data.expectedInvDate,
      "sales_lead": data.salesLead,
      "client": data.client?.id,
      "sub_org": null,
      "billing_address": data.billingAddress?.id,
      "shipping_address": data.shippingAddress?.id,
      "payment_term": data.paymentTerm?.id,
      "delivery_term": data.deliveryTerm?.id,
      "contact_to": data.contactTo?.id,
      "department": data.department?.id,
      "so_status": data.soStatus,
      "transportation_term": data.transportationTerm?.id,
      "org": data.org?.id,
      "parts": jsonEncodedMap
    };
    return await SalesOrderNetwork.salesOrderAdd(params, data.id);
  }

  Future<dynamic> addSalesOrderDocumentApiCall(
      {File? selectedFile, String? salesLeadId, String? mediaType}) async {
    String fileName = selectedFile!.path.split('/').last;

    var params = FormData.fromMap({
      "so_id": salesLeadId,
      "media_type": mediaType,
      "name": fileName,
      "attachment":
          await MultipartFile.fromFile(selectedFile.path, filename: fileName),
    });
    return await SalesOrderNetwork.addSalesLeadDocument(params);
  }

  Future<dynamic> createSalesOrderApiCall(
      {String? poData,
      String? discretion,
      String? refPO,
      String? expectedINvoiceData,
      String? salesLeadID,
      String? clientID,
      String? billingAddress,
      String? shippingAddress,
      int? paymentTerm,
      int? deliveryTerm,
      String? contactTo,
      String? status,
      int? transportationID,
      String? organizationID}) async {
    final params = {
      "po_date": poData,
      "description": discretion,
      "comments": "",
      "created_by": AppConstant.userData!.userId!,
      "ref_po": refPO,
      "expected_inv_date": expectedINvoiceData,
      "sales_lead": salesLeadID,
      "client": clientID,
      "sub_org": null,
      "billing_address": '776540e0-828b-4c20-aa7f-6675e2a2a083',
      "shipping_address": '776540e0-828b-4c20-aa7f-6675e2a2a083',
      "payment_term": paymentTerm,
      "delivery_term": deliveryTerm,
      "contact_to": contactTo,
      "so_status": status,
      "transportation_term": transportationID,
      "parts": [],
      "org": organizationID
    };
    return await SalesOrderNetwork.createSalesOrder(params);
  }

  Future<dynamic> paymentTermApiCall() async {
    return await SalesOrderNetwork.getPaymentTerm();
  }

  Future<dynamic> deliveryTermApiCall() async {
    return await SalesOrderNetwork.getDeliveryTerm();
  }

  Future<dynamic> transportationTermApiCall() async {
    return await SalesOrderNetwork.getTransportationTerm();
  }

  Future<dynamic> addressListApiCall({String? organizationID}) async {
    var params = {"org": organizationID};
    return await SalesOrderNetwork.getAddress(params);
  }
}
