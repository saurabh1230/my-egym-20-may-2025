import '../../utils/images.dart';

class MemberModel {
  final int id;
  final int userId;
  final int parentId;
  final String traineeId;
  final int trainerAssign;
  final String? photo;
  final String fullName;
  final String dateOfBirth;
  final int age;
  final String gender;
  final String? relationship;
  final String address;
  final String? zipCode;
  final String phoneNumber;
  final String email;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? emergencyContactRelationship;
  final String? identityProof;
  final int isActive;
  final int isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  MemberModel({
    required this.id,
    required this.userId,
    required this.parentId,
    required this.traineeId,
    required this.trainerAssign,
    this.photo,
    required this.fullName,
    required this.dateOfBirth,
    required this.age,
    required this.gender,
    this.relationship,
    required this.address,
    this.zipCode,
    required this.phoneNumber,
    required this.email,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactRelationship,
    this.identityProof,
    required this.isActive,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'],
      userId: json['user_id'],
      parentId: json['parent_id'],
      traineeId: json['trainee_id'],
      trainerAssign: json['trainer_assign'],
      photo: json['photo'] ?? "",
      fullName: json['full_name'],
      dateOfBirth: json['date_of_birth'],
      age: json['age'],
      gender: json['gender'],
      relationship: json['relationship'],
      address: json['address'],
      zipCode: json['zip_code'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      emergencyContactName: json['emergency_contact_name'],
      emergencyContactPhone: json['emergency_contact_phone'],
      emergencyContactRelationship: json['emergency_contact_relationship'],
      identityProof: json['identity_proof'],
      isActive: json['is_active'],
      isDeleted: json['is_deleted'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
