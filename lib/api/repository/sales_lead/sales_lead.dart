import 'package:wikitek/api/network/sales_lead/sales_lead.dart';
import 'package:wikitek/utility/constant.dart';

class SalesLeadRepository {
  Future<dynamic> salesLeadApiCall({String? year}) async {
    final params = {
      "org": AppConstant.userData!.org!.id!,
      "financial_year": year
    };
    return await SalesLeadNetwork.getSalesLead(params);
  }
}
