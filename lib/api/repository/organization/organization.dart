import 'package:wikitek/api/network/organization/organization.dart';

class OrganizationRepository {
  Future<dynamic> organizationApiCall() async {
    return await OrganizationNetwork.getOrganization();
  }
}
