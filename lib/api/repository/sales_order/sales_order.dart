import 'dart:convert';

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
    data!.parts!.removeAt(index!);
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
      "parts_no": partData.id
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
}
