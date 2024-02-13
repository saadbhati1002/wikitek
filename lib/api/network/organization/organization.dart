import 'package:wikitek/api/http_manager.dart';
import 'package:wikitek/models/organization/organization_model.dart';

class OrganizationNetwork {
  static const String organizationUrl = "organizations/fetch/org/";

  static Future<dynamic> getOrganization() async {
    final result = await httpManager.get(url: organizationUrl);
    OrganizationRes leadRes = OrganizationRes.fromJson(result);
    return leadRes;
  }
}
