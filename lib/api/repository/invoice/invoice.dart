import 'package:wikitek/api/network/invoice/invoice.dart';
import 'package:wikitek/utility/constant.dart';

class InvoiceRepository {
  Future<dynamic> invoiceApiCall({String? year}) async {
    final params = {
      "org": AppConstant.userData!.org!.id!,
      "financial_year": year
    };
    return await InvoiceNetwork.getInvoice(params);
  }
}
