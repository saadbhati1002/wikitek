import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wikitek/api/network/engineering/engineering.dart';

class EngineeringRepository {
  Future<dynamic> getEngineeringListApiCall() async {
    return await EngineeringNetwork.getEngineeringList();
  }

  Future<dynamic> getEngineeringBacklogApiCall(
      {String? engineeringBacklog}) async {
    return await EngineeringNetwork.getEngineeringBackLog(
        engineeringID: engineeringBacklog);
  }

  Future<dynamic> addSalesLeadDocumentApiCall(
      {File? selectedFile, String? engineeringID, String? mediaType}) async {
    String fileName = selectedFile!.path.split('/').last;

    var params = FormData.fromMap({
      "project": engineeringID,
      "document_type": mediaType,
      "name": fileName,
      "attachment":
          await MultipartFile.fromFile(selectedFile.path, filename: fileName),
    });
    return await EngineeringNetwork.addEngineeringDocument(params);
  }
}
