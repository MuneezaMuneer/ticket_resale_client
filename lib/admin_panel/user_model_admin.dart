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
