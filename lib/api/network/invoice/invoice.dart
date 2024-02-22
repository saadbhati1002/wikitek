import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/invoice/invoice_model.dart';
import 'package:wikitek/models/invoice/serial_number/serial_number_model.dart';

class InvoiceNetwork {
  static const String invoiceUrl = "invoices/fetch/all/invoices/";
  static const String invoicePartSerialNumberUrl =
      "invoices/fetch/all/invoices/get_serialized_parts/";

  static Future<dynamic> getInvoice(param) async {
    final result = await httpManager.get(url: invoiceUrl, params: param);
    InvoiceRes leadRes = InvoiceRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> getInvoicePartSerialNumber(param) async {
    print(param);
    final result =
        await httpManager.get(url: invoicePartSerialNumberUrl, params: param);
    print(result);
    SerialNumberRes leadRes = SerialNumberRes.fromJson(result);
    return leadRes;
  }
}
