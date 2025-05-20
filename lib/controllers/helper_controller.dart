import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myegym/data/models/add_activity_model.dart';

import 'package:myegym/utils/date_converter.dart';

class HelperController extends GetxController {
  String _selectedDateBirth = '';
  String get selectedDateBirth => _selectedDateBirth;

  void selectDate(String val) {
    _selectedDateBirth = val;
    update();
  }

  Future<void> selectDateBirthFunction(BuildContext context,
      {bool? isSlash = false}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2007),
      firstDate: DateTime(1970),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      if(isSlash = true) {
        _selectedDateBirth = DateConverter.formatToSlashFormat(pickedDate);
      } else {
        _selectedDateBirth = DateConverter.formatToDashFormat(pickedDate);

      }

      update();
    }
  }

  String _selectedStartDate = '';
  String get selectedStartDate => _selectedStartDate;

  void selectStartDate(String val) {
    _selectedStartDate = val;
    update();
  }

  Future<void> selectStartDateDateFunction(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      _selectedStartDate = DateConverter.formatToSlashFormat(pickedDate);
      update();
    }
  }

  String _selectedEndDate = '';
  String get selectedEndDate => _selectedEndDate;

  void selectEndDate(String val) {
    _selectedEndDate = val;
    update();
  }

  Future<void> selectEndDDateFunction(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      _selectedEndDate = DateConverter.formatToSlashFormat(pickedDate);
      update();
    }
  }

  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;

  void pickImage({required bool isRemove}) async {
    if (isRemove) {
      _pickedImage = null;
    } else {
      _pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    update();
  }

  XFile? _pickedDocument;
  XFile? get pickedDocument => _pickedDocument;

  void pickDocument({required bool isRemove}) async {
    if (isRemove) {
      _pickedDocument = null;
    } else {
      _pickedDocument =
          await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    update();
  }

  String? validateName(String? value) => (value == null || value.trim().isEmpty)
      ? 'Trainer name is required'
      : null;

  String? validateDOB(String? value) => (value == null || value.trim().isEmpty)
      ? 'Date of birth is required'
      : null;

  String? validateDate(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Date is required' : null;

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Phone number is required';
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value))
      return 'Enter a valid 10-digit phone number';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Email address is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
      return 'Enter a valid email address';
    return null;
  }

  String? validateYearsOfExperience(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Years of experience is required';
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) return 'Enter a valid number';
    return null;
  }

  String? validateAddress(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Address is required' : null;

  String? validateLink(String? value) {
    if (value == null || value.trim().isEmpty) return 'Link is required';
    if (!value.contains("http")) return 'Enter a valid link';
    return null;
  }

  String? validateZipCode(String? value) {
    if (value == null || value.trim().isEmpty) return 'Zip Code is required';
    if (value.length < 6) return 'Zip Code must be at least 6 characters long';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters long';
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty)
      return 'Confirm password is required';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  String? validate(String? value) =>
      (value == null || value.trim().isEmpty) ? '$value is required' : null;

  var workoutDays = <WorkoutDay>[].obs;

  void addWorkoutDay(WorkoutDay day) {
    workoutDays.add(day);
  }

  void clearWorkoutDays() {
    workoutDays.clear();
  }

  List<Map<String, dynamic>> get workoutDaysJson =>
      workoutDays.map((e) => e.toJson()).toList();
}
