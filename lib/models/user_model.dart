class UserModel {
  final String? displayName;
  final String? email;
  final String? instaUsername;
  final String? phoneNo;
  final String? birthDate;
  final String? photoUrl;

  UserModel(
      {this.displayName,
      this.email,
      this.instaUsername,
      this.phoneNo,
      this.birthDate,
      this.photoUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'instagram_username': instaUsername,
      'phone_number': phoneNo,
      'birth_date': birthDate,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      instaUsername: map['instagram_username'] ?? "",
      phoneNo:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      birthDate: map['birth_date'] != null ? map['birth_date'] as String : null,
    );
  }
}
