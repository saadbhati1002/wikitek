import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/invoice/invoice_model.dart';
import 'package:wikitek/models/invoice/payment/payment_model.dart';
import 'package:wikitek/models/invoice/serial_number/serial_number_model.dart';

class InvoiceNetwork {
  static const String invoiceUrl = "invoices/fetch/all/invoices/";
  static const String invoicePartSerialNumberUrl =
      "invoices/fetch/all/invoices/get_serialized_parts/";
  static const String invoiceDetailUrl = "invoices/get/payment/";

  static Future<dynamic> getInvoice(param) async {
    final result = await httpManager.get(url: invoiceUrl, params: param);
    print(result);
    InvoiceRes leadRes = InvoiceRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> getInvoicePartSerialNumber(param) async {
    final result =
        await httpManager.get(url: invoicePartSerialNumberUrl, params: param);

    SerialNumberRes leadRes = SerialNumberRes.fromJson(result);
    return leadRes;
  }

  static Future<dynamic> getInvoiceAmountPaid(param) async {
    final result = await httpManager.get(url: invoiceDetailUrl, params: param);

    InvoiceAmount leadRes = InvoiceAmount.fromJson(result);
    return leadRes;
  }
}
