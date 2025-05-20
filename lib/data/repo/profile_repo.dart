import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:myegym/data/api/api_client.dart';
import 'package:myegym/utils/app_constants.dart';

class ProfileRepo {
  final ApiClient apiClient;
  ProfileRepo({required this.apiClient});

  Future<Response> getOwnerDetails() async {
    return await apiClient.getData(AppConstants.gymDetailUrl, method: "GET");
  }
}
