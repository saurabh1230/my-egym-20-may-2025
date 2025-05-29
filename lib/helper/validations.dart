class Validators {
  static String? validateName(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Trainer name is required' : null;

  static String? validateDOB(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Date of birth is required' : null;

  static String? validateDate(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Date is required' : null;

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return 'Enter a valid 10-digit phone number';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email address is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  static String? validateYearsOfExperience(String? value) {
    if (value == null || value.trim().isEmpty) return 'Years of experience is required';
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) return 'Enter a valid number';
    return null;
  }

  static String? validateAddress(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Address is required' : null;

  static String? validateLink(String? value) {
    if (value == null || value.trim().isEmpty) return 'Link is required';
    if (!value.contains("http")) return 'Enter a valid link';
    return null;
  }

  static String? validateZipCode(String? value) {
    if (value == null || value.trim().isEmpty) return 'Zip Code is required';
    if (value.length < 6) return 'Zip Code must be at least 6 characters long';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters long';
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) return 'Confirm password is required';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  static String? validate(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Field is required' : null;
}
