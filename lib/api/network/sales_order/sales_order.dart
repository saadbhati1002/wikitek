import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/sales_order/sales_order_model.dart';

class SalesOrderNetwork {
  static const String salesOrderUrl = "pipo/so/order/";
  static Future<dynamic> getSalesOrder(prams) async {
    final result = await httpManager.get(url: salesOrderUrl, params: prams);
    SalesOrderRes leadRes = SalesOrderRes.fromJson(result);
    return leadRes;
  }
}
