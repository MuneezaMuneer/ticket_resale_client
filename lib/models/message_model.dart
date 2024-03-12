import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? message;
  DateTime? time;
  String? userIDReceiver;
  String? userIDSender;
  MessageModel({
    this.message,
    this.time,
    this.userIDReceiver,
    this.userIDSender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'time': FieldValue.serverTimestamp(),
      'user_id_receiver': userIDReceiver,
      'user_id_sender': userIDSender,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    Timestamp? time = map['time'];
    final dateTime = time == null ? DateTime.now() : time.toDate();
    return MessageModel(
      message: map['message'] != null ? map['message'] as String : null,
      time: dateTime,
      userIDReceiver: map['user_id_receiver'] != null
          ? map['user_id_receiver'] as String
          : null,
      userIDSender: map['user_id_sender'] != null
          ? map['user_id_sender'] as String
          : null,
    );
  }
}
