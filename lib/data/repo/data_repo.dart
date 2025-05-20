import 'package:get/get_connect/http/src/response/response.dart';
import 'package:myegym/data/api/api_client.dart';
import 'package:myegym/utils/app_constants.dart';

class DataRepo {
  final ApiClient apiClient;
  DataRepo({required this.apiClient});

  Future<Response> getQualificationRepo() async {
    return await apiClient.getData(AppConstants.qualification, method: "GET");
  }

  Future<Response> getSpecializationRepo() async {
    return await apiClient.getData(AppConstants.specialization, method: "GET");
  }
}
