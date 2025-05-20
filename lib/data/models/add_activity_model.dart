class WorkoutDay {
  final String day;
  final String activity;
  final List<SubActivity> subactivities;

  WorkoutDay({
    required this.day,
    required this.activity,
    required this.subactivities,
  });

  factory WorkoutDay.fromJson(Map<String, dynamic> json) {
    return WorkoutDay(
      day: json['day'],
      activity: json['activity'],
      subactivities: (json['subactivities'] as List)
          .map((e) => SubActivity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'activity': activity,
      'subactivities': subactivities.map((e) => e.toJson()).toList(),
    };
  }
}

class SubActivity {
  final String id;
  final String sets;
  final String reps;
  final String weight;
  final String rest;

  SubActivity({
    required this.id,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.rest,
  });

  factory SubActivity.fromJson(Map<String, dynamic> json) {
    return SubActivity(
      id: json['id'],
      sets: json['sets'],
      reps: json['reps'],
      weight: json['weight'],
      rest: json['rest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'rest': rest,
    };
  }
}
