class OwnerProfileModel {
  final int id;
  final String gymId;
  final int parentId;
  final String name;
  final String email;
  final String type;
  final String profile;
  final String phoneNumber;
  final String lang;
  final int subscription;
  final String? subscriptionExpireDate;
  final int ownerId;
  final String? emailVerifiedAt;
  final String? emailVerificationToken;
  final String? twofaSecret;
  final int isActive;
  final String createdAt;
  final String updatedAt;

  OwnerProfileModel({
    required this.id,
    required this.gymId,
    required this.parentId,
    required this.name,
    required this.email,
    required this.type,
    required this.profile,
    required this.phoneNumber,
    required this.lang,
    required this.subscription,
    this.subscriptionExpireDate,
    required this.ownerId,
    this.emailVerifiedAt,
    this.emailVerificationToken,
    this.twofaSecret,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OwnerProfileModel.fromJson(Map<String, dynamic> json) {
    return OwnerProfileModel(
      id: json['id'],
      gymId: json['gym_id'],
      parentId: json['parent_id'],
      name: json['name'],
      email: json['email'],
      type: json['type'],
      profile: json['profile'],
      phoneNumber: json['phone_number'],
      lang: json['lang'],
      subscription: json['subscription'],
      subscriptionExpireDate: json['subscription_expire_date'],
      ownerId: json['owner_id'],
      emailVerifiedAt: json['email_verified_at'],
      emailVerificationToken: json['email_verification_token'],
      twofaSecret: json['twofa_secret'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gym_id': gymId,
      'parent_id': parentId,
      'name': name,
      'email': email,
      'type': type,
      'profile': profile,
      'phone_number': phoneNumber,
      'lang': lang,
      'subscription': subscription,
      'subscription_expire_date': subscriptionExpireDate,
      'owner_id': ownerId,
      'email_verified_at': emailVerifiedAt,
      'email_verification_token': emailVerificationToken,
      'twofa_secret': twofaSecret,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
