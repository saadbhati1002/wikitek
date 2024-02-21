import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/invoice/invoice_model.dart';

class InvoiceNetwork {
  static const String invoiceUrl = "invoices/fetch/all/invoices/";

  static Future<dynamic> getInvoice(param) async {
    final result = await httpManager.get(url: invoiceUrl, params: param);

    InvoiceRes leadRes = InvoiceRes.fromJson(result);
    return leadRes;
  }
}
