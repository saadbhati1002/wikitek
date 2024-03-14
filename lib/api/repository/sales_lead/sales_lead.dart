import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
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
    data!.parts.removeAt(index!);
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
    var id = partData.id.toString();
    print(id);
    var newMap = {
      "part_id": id,
      "short_description": shortDescription,
      "quantity": quantity,
      "unit_cost": partData.mrp.toString(),
      "status": "Active",
      "gst": gst,
      "net_price": (partData.mrp! * quantity).toString(),
      "extd_gross_price": partData.calculatedPrice.toString(),
    };
    print(newMap);

    List jsonEncodedMap = [];
    for (int i = 0; i < data!.parts.length; i++) {
      jsonEncodedMap.add({
        "part_id": data.parts[i].partId!.id!,
        "short_description": data.parts[i].shortDescription.toString(),
        "quantity": data.parts[i].quantity.toString(),
        "unit_cost": data.parts[i].unitCost.toString(),
        "status": "Active",
        "gst": data.parts[i].gst,
        "net_price": data.parts[i].netPrice,
        "extd_gross_price": data.parts[i].expdGrossPrice,
      });
    }
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

  Future<dynamic> addSalesHistoryApiCall(
      {String? comment, String? date, String? salesLead}) async {
    var params = {
      "saleslead": salesLead,
      "date": date,
      "created_by": AppConstant.userData!.userId!,
      "comment": comment,
    };
    return await SalesLeadNetwork.addLeadHistory(params);
  }

  Future<dynamic> addSalesLeadDocumentApiCall(
      {File? selectedFile, String? salesLeadId, String? mediaType}) async {
    String fileName = selectedFile!.path.split('/').last;

    var params = FormData.fromMap({
      "saleslead": salesLeadId,
      "media_type": mediaType,
      "name": fileName,
      "created_by": AppConstant.userData!.userId!,
      "attachment":
          await MultipartFile.fromFile(selectedFile.path, filename: fileName),
    });
    return await SalesLeadNetwork.addSalesLeadDocument(params);
  }

  Future<dynamic> addSalesLeadApiCall(
      {String? departmentId,
      String? clientID,
      String? expectedDate,
      String? expectedInvoiceDate,
      String? name,
      String? mobileNumber,
      String? email,
      String? description,
      String? probability,
      String? status}) async {
    var params = {
      "department": departmentId,
      "sub_org": null,
      "probability": probability,
      "total": 0,
      "status": status,
      "client": clientID,
      "expected_date": expectedDate,
      "expected_invoice_date": expectedInvoiceDate,
      "contact_name": name,
      "Email": email,
      "mobile": mobileNumber,
      "description": description,
      "parts": [],
      "extd_gross_price": 0.0,
      "org": AppConstant.userData!.org!.id!,
      "email": email
    };
    return await SalesLeadNetwork.addMainSalesLead(params);
  }
}
