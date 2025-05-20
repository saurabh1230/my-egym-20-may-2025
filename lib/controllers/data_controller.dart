import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/loading_dialog.dart';
import 'package:myegym/data/models/qualification_model.dart';
import 'package:myegym/data/models/specialization_model.dart';
import 'package:myegym/data/models/trainer_model.dart';
import 'package:myegym/data/repo/data_repo.dart';
import 'package:myegym/data/repo/trainer_repo.dart'; // For date formatting

class DataController extends GetxController {
  final DataRepo dataRepo;
  DataController({required this.dataRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<QualificationModel>? _qualificationModel;
  List<QualificationModel>? get qualificationModel => _qualificationModel;

  final Rx<QualificationModel?> selectedQualification =
      Rx<QualificationModel?>(null);

  int _selectedQualificationId = 0;
  int get selectedQualificationId => _selectedQualificationId;

  void selectQualificationId(int val) {
    _selectedQualificationId = val;
    update();
  }

  Future<void> getQualificationList() async {
    _isLoading = true;
    update();

    try {
      Response response = await dataRepo.getQualificationRepo();

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['qualification'];
        _qualificationModel = responseData
            .map((json) => QualificationModel.fromJson(json))
            .toList();

        // ✅ Set first item as default if list is not empty
        if (_qualificationModel != null && _qualificationModel!.isNotEmpty) {
          selectedQualification.value = _qualificationModel!.first;
          _selectedQualificationId = _qualificationModel!.first.id;
        }
      } else {
        print("Error in getQualificationList Load");
      }
    } catch (error) {
      print("Error while fetching getQualificationList list: $error");
    }

    _isLoading = false;
    update();
  }

  List<SpecializationModel>? _specializationModel;
  List<SpecializationModel>? get specializationModel => _specializationModel;

  final Rx<SpecializationModel?> selectedSpecialization =
      Rx<SpecializationModel?>(null);
  final RxList<int> selectedSpecializationIds = <int>[].obs;

  Future<void> getSpecializationList() async {
    _isLoading = true;
    update();

    try {
      Response response = await dataRepo.getSpecializationRepo();

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['specialization'];

        // ✅ Convert and filter only items with status == 1
        _specializationModel = responseData
            .map((json) => SpecializationModel.fromJson(json))
            .where((model) => model.status == 1)
            .toList();

        // ✅ Set default selection if available
        if (_specializationModel != null && _specializationModel!.isNotEmpty) {
          selectedSpecialization.value = _specializationModel!.first;
        }
      } else {
        print("Error in specialization Load");
      }
    } catch (error) {
      print("Error while fetching specialization list: $error");
    }

    _isLoading = false;
    update();
  }
}
