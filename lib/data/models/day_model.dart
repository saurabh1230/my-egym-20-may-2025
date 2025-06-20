class DayModel {
  final int dayId;
  final int weekId;
  final String dayName;

  DayModel({required this.dayId, required this.weekId, required this.dayName});

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      dayId: json['day_id'],
      weekId: json['week_id'],
      dayName: json['day_name'],
    );
  }
}
