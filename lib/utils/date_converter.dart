import 'package:intl/intl.dart';

class DateFormatterOnlyDate {
  /// Converts a date string like "2025-04-24 06:25:06" to "24-04-2025"
  static String formatToIndianDate(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return '';
    }
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      final year = dateTime.year.toString();
      return "$day-$month-$year";
    } catch (e) {
      return '';
    }
  }
}

class DateConverter {
  /// Converts "dd-MM-yyyy" string to "dd/MM/yyyy" format
  static String dashToSlash(String dashDate) {
    try {
      final parts = dashDate.split('-');
      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        final year = parts[2];
        return '$day/$month/$year';
      }
    } catch (_) {}
    return dashDate; // fallback if format is wrong
  }

  /// Converts DateTime to "dd-MM-yyyy"
  static String formatToDashFormat(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day-$month-$year';
  }

  /// Converts DateTime to "dd/MM/yyyy"
  static String formatToSlashFormat(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  static String formatDateDMYString({
    required String inputDate,
    required String inputFormat,
    required String outputFormat,
  }) {
    try {
      final dateTime = DateFormat(inputFormat).parse(inputDate);
      return DateFormat(outputFormat).format(dateTime);
    } catch (e) {
      print('Date formatting error: $e');
      return inputDate; // fallback
    }
  }
}
