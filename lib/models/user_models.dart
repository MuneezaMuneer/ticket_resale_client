class UserModelClient {
  final String? displayName;
  final String? email;
  final String? instaUsername;
  final String? phoneNo;
  final String? birthDate;
  final String? photoUrl;
  Map<String, dynamic>? profileLevels = {};
  final String? id;
  final String? status;
  final String? fcmToken;
  final bool? commentValue;

  UserModelClient({
    this.fcmToken,
    this.commentValue,
    this.status,
    this.displayName,
    this.email,
    this.id,
    this.instaUsername,
    this.phoneNo,
    this.birthDate,
    this.photoUrl,
    this.profileLevels,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'instagram_username': instaUsername,
      'email': email,
      'user_name': displayName,
      'phone_number': phoneNo,
      'birth_date': birthDate,
      'profile_levels': profileLevels,
      'status': status,
      'image_url': photoUrl,
      'comment_value': true
    };
  }

  Map<String, dynamic> toWithTokenMap() {
    return <String, dynamic>{
      'instagram_username': instaUsername,
      'user_name': displayName,
      'phone_number': phoneNo,
      'birth_date': birthDate,
      'profile_levels': profileLevels,
      'status': status,
      'image_url': photoUrl,
      'fcm_token': fcmToken,
      'email': email,
      'comment_value': true
    };
  }

  factory UserModelClient.fromMap(Map<String, dynamic> map, String id) {
    return UserModelClient(
        id: id,
        status: map['status'] ?? '',
        instaUsername: map['instagram_username'] ?? "",
        phoneNo: map['phone_number'] ?? '',
        birthDate: map['birth_date'] ?? '',
        photoUrl: map['image_url'] ?? '',
        profileLevels: map['profile_levels'] ?? Map,
        displayName: map['user_name'] ?? '',
        fcmToken: map['fcm_token'] ?? '',
        commentValue: map['comment_value'] ?? false);
  }
  int getProfileLevelsLength(Map<String, dynamic>? profileLevels) {
    return profileLevels?.length ?? 0;
  }
}

class UserModelAdmin {
  String? name;
  String? email;
  String? phoneNo;
  String? instaUsername;
  String? status;
  String? userID;
  String? id;
  UserModelAdmin({
    this.name,
    this.email,
    this.phoneNo,
    this.instaUsername,
    this.status,
    this.id,
    this.userID,
  });
  factory UserModelAdmin.fromMap(Map<String, dynamic> map, String docID) {
    return UserModelAdmin(
        name: map['user_name'] ?? '',
        email: map['email'] ?? '',
        phoneNo: map['phone_number'] ?? '',
        instaUsername: map['instagram_username'] ?? '',
        status: map['status'] ?? '',
        userID: map['user_id'] ?? '',
        id: docID);
  }
}
