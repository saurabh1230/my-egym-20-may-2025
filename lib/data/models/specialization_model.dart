class SpecializationModel {
  final int id;
  final String name;
  final int status;
  final int parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  SpecializationModel({
    required this.id,
    required this.name,
    required this.status,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      parentId: json['parent_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'parent_id': parentId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
