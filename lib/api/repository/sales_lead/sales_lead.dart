import 'package:wikitek/api/network/sales_lead/sales_lead.dart';
import 'package:wikitek/models/lead/lead_model.dart';
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
      "parts": data.parts
    };
    return await SalesLeadNetwork.updateSalesLead(params, data.leadNo);
  }
}
