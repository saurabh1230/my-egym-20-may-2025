

class WeekModel {
  final int weekId;
  final int monthId;
  final String weekName;

  WeekModel({required this.weekId, required this.monthId, required this.weekName});

  factory WeekModel.fromJson(Map<String, dynamic> json) {
    return WeekModel(
      weekId: json['week_id'],
      monthId: json['month_id'],
      weekName: json['week_name'],
    );
  }
}
