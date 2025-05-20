// import 'package:myegym/data/models/member_model.dart';

// class TrainerMemberResponse {
//   final String status;
//   final List<TrainerModel> trainer;
//   final List<MemberModel> members;

//   TrainerMemberResponse({
//     required this.status,
//     required this.trainer,
//     required this.members,
//   });

//   factory TrainerMemberResponse.fromJson(Map<String, dynamic> json) {
//     return TrainerMemberResponse(
//       status: json['status'],
//       trainer: List<TrainerModel>.from(
//           json['trainer'].map((x) => TrainerModel.fromJson(x))),
//       members: List<MemberModel>.from(
//           json['members'].map((x) => MemberModel.fromJson(x))),
//     );
//   }
// }

// class TrainerModel {
//   final int id;
//   final String trainerId;
//   final int userId;
//   final int parentId;
//   final String fullName;
//   final String dateOfBirth;
//   final String type;
//   final int age;
//   final String gender;
//   final String? relationship;
//   final String address;
//   final String? zipCode;
//   final String phoneNumber;
//   final String email;
//   final String? emergencyContactName;
//   final String? emergencyContactPhone;
//   final String? emergencyContactRelationship;
//   final String instaProfileLink;
//   final String facebookProfileLink;
//   // final String qualification;
//   // final String specializations;
//   final Qualification qualification;
//   final List<String> specializations;
//   final String experienceInYear;
//   final String? photo;
//   final String? identityProof;
//   final dynamic isDeleted;
//   final String? deletedAt;
//   final int isActive;
//   final String createdAt;
//   final String updatedAt;

//   TrainerModel({
//     required this.id,
//     required this.trainerId,
//     required this.userId,
//     required this.parentId,
//     required this.fullName,
//     required this.dateOfBirth,
//     required this.type,
//     required this.age,
//     required this.gender,
//     this.relationship,
//     required this.address,
//     this.zipCode,
//     required this.phoneNumber,
//     required this.email,
//     this.emergencyContactName,
//     this.emergencyContactPhone,
//     this.emergencyContactRelationship,
//     required this.instaProfileLink,
//     required this.facebookProfileLink,
//     required this.qualification,
//     required this.specializations,
//     required this.experienceInYear,
//     this.photo,
//     this.identityProof,
//     this.isDeleted,
//     this.deletedAt,
//     required this.isActive,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory TrainerModel.fromJson(Map<String, dynamic> json) {
//     return TrainerModel(
//       id: json['id'],
//       trainerId: json['trainer_id'],
//       userId: json['user_id'],
//       parentId: json['parent_id'],
//       fullName: json['full_name'],
//       dateOfBirth: json['date_of_birth'],
//       type: json['type'],
//       age: json['age'],
//       gender: json['gender'],
//       relationship: json['relationship'],
//       address: json['address'],
//       zipCode: json['zip_code'],
//       phoneNumber: json['phone_number'],
//       email: json['email'],
//       emergencyContactName: json['emergency_contact_name'],
//       emergencyContactPhone: json['emergency_contact_phone'],
//       emergencyContactRelationship: json['emergency_contact_relationship'],
//       instaProfileLink: json['instaProfileLink'],
//       facebookProfileLink: json['facebookProfileLink'],
//       qualification: Qualification.fromJson(json['qualification']),
//       specializations: List<String>.from(json['specializations']),
//       experienceInYear: json['experienceinyear'],
//       photo: json['photo'],
//       identityProof: json['identity_proof'],
//       isDeleted: json['is_deleted'],
//       deletedAt: json['deleted_at'],
//       isActive: json['is_active'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }

// class Qualification {
//   final String id;
//   final String name;

//   Qualification({required this.id, required this.name});

//   factory Qualification.fromJson(Map<String, dynamic> json) {
//     return Qualification(
//       id: json['id'],
//       name: json['name'],
//     );
//   }
// }
