class TrainerDetailsResponse {
  final String status;
  final TrainerDetails trainer;
  final List<MemberDetails> members;

  TrainerDetailsResponse({
    required this.status,
    required this.trainer,
    required this.members,
  });

  factory TrainerDetailsResponse.fromJson(Map<String, dynamic> json) {
    return TrainerDetailsResponse(
      status: json['status'],
      trainer: TrainerDetails.fromJson(json['trainer']),
      members: List<MemberDetails>.from(
          json['members'].map((x) => MemberDetails.fromJson(x))),
    );
  }
}

class TrainerDetails {
  final int id;
  final String trainerId;
  final int userId;
  final int parentId;
  final String fullName;
  final String dateOfBirth;
  final String type;
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
  final String? instaProfileLink;
  final String? facebookProfileLink;
  final String qualification;
  final String specializations;
  final String experienceInYear;
  final String? photo;
  final String? identityProof;
  final dynamic isDeleted;
  final String? deletedAt;
  final int isActive;
  final String createdAt;
  final String updatedAt;

  TrainerDetails({
    required this.id,
    required this.trainerId,
    required this.userId,
    required this.parentId,
    required this.fullName,
    required this.dateOfBirth,
    required this.type,
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
    this.instaProfileLink,
    this.facebookProfileLink,
    required this.qualification,
    required this.specializations,
    required this.experienceInYear,
    this.photo,
    this.identityProof,
    this.isDeleted,
    this.deletedAt,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrainerDetails.fromJson(Map<String, dynamic> json) {
    return TrainerDetails(
      id: json['id'],
      trainerId: json['trainer_id'],
      userId: json['user_id'],
      parentId: json['parent_id'],
      fullName: json['full_name'],
      dateOfBirth: json['date_of_birth'],
      type: json['type'],
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
      instaProfileLink: json['instaProfileLink'],
      facebookProfileLink: json['facebookProfileLink'],
      qualification: json['qualification'],
      specializations: json['specializations'],
      experienceInYear: json['experienceinyear'],
      photo: json['photo'],
      identityProof: json['identity_proof'],
      isDeleted: json['is_deleted'],
      deletedAt: json['deleted_at'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class MemberDetails {
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

  MemberDetails({
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

  factory MemberDetails.fromJson(Map<String, dynamic> json) {
    return MemberDetails(
      id: json['id'],
      userId: json['user_id'],
      parentId: json['parent_id'],
      traineeId: json['trainee_id'],
      trainerAssign: json['trainer_assign'],
      photo: json['photo'],
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
