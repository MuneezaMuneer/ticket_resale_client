class UserModelAdmin {
  String? name;
  String? email;
  String? phoneNo;
  String? instaUsername;
  UserModelAdmin({
    this.name,
    this.email,
    this.phoneNo,
    this.instaUsername,
  });
  factory UserModelAdmin.fromMap(Map<String, dynamic> map) {
    return UserModelAdmin(
      name: map['user_name'] ?? '',
      email: map['email'] ?? '',
      phoneNo: map['phone_number'] ?? '',
      instaUsername: map['instagram_username'] ?? '',
    );
  }
}
