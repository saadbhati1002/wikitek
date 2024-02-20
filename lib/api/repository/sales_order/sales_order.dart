import 'package:wikitek/api/network/sales_order/sales_order.dart';
import 'package:wikitek/utility/constant.dart';

class SalesOrderRepository {
  Future<dynamic> salesOrderApiCall({String? year}) async {
    final params = {
      "org": AppConstant.userData!.org!.id!,
      "financial_year": year
    };
    return await SalesOrderNetwork.getSalesOrder(params);
  }
}
