import 'dart:convert';

import 'package:wikitek/api/network/sales_lead/sales_lead.dart';
import 'package:wikitek/models/lead/lead_model.dart';
import 'package:wikitek/models/lead/part/part_model.dart';
import 'package:wikitek/utility/constant.dart';

class SalesLeadRepository {
  Future<dynamic> salesLeadApiCall({String? year}) async {
    final params = {
      "org": AppConstant.userData!.org!.id!,
      "financial_year": year
    };
    return await SalesLeadNetwork.getSalesLead(params);
  }

  Future<dynamic> salesLeadUpdateApiCall(
      {SalesLeadData? data, int? index}) async {
    data!.parts!.removeAt(index!);
    var part = jsonEncode(data.parts);
    final params = {
      "lead_no": data.leadNo,
      "org": data.org!.id,
      "client": data.client!.id,
      "sub_org": null,
      "department": data.department?.id,
      "expected_date": data.expectedDate,
      "expected_invoice_date": data.expectedInvoiceDate,
      "status": data.status,
      "description": data.description,
      "mobile": data.mobile,
      "email": data.email,
      "contact_name": data.contactName,
      "total": data.total,
      "probability": data.probability,
      "parts": jsonDecode(part)
    };
    return await SalesLeadNetwork.updateSalesLead(params, data.leadNo);
  }

  Future<dynamic> addSalesLeadUpdateApiCall(
      {SalesLeadData? data, PartData? partData}) async {
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
      "extd_gross_price": partData.calculatedPrice.toString()
    };

    var part = jsonEncode(data!.parts);
    List jsonEncodedMap = jsonDecode(part);
    jsonEncodedMap.add(newMap);

    final params = {
      "lead_no": data.leadNo,
      "org": data.org!.id,
      "client": data.client!.id,
      "sub_org": null,
      "department": data.department?.id,
      "expected_date": data.expectedDate,
      "expected_invoice_date": data.expectedInvoiceDate,
      "status": data.status,
      "description": data.description,
      "mobile": data.mobile,
      "email": data.email,
      "contact_name": data.contactName,
      "total": data.total,
      "probability": data.probability,
      "parts": jsonEncodedMap
    };
    return await SalesLeadNetwork.addSalesLead(params, data.leadNo);
  }

  Future<dynamic> getLeadPartsApiCall() async {
    return await SalesLeadNetwork.getLeadParts();
  }
}
