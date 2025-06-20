class MonthModel {
  final int monthId;
  final String monthName;

  MonthModel({required this.monthId, required this.monthName});

  factory MonthModel.fromJson(Map<String, dynamic> json) {
    return MonthModel(
      monthId: json['month_id'],
      monthName: json['month_name'],
    );
  }
}
