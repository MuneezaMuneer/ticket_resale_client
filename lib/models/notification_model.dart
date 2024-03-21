import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? title;
  String? body;
  Timestamp? time;
  String? notificationType;
  String? id;
  String? userId;
  String? status;
  String? docId;
  NotificationModel(
      {this.title,
      this.body,
      this.time,
      this.id,
      this.userId,
      this.status,
      this.notificationType,
      this.docId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'time': FieldValue.serverTimestamp(),
      'id': id,
      'user_id': userId,
      'status': status,
      'notification_type': notificationType
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map, String docId) {
    return NotificationModel(
        title: map['title'] ?? '',
        body: map['body'] ?? '',
        time: map['time'] ?? Timestamp.now(),
        id: map['id'] ?? '',
        userId: map['user_id'] ?? '',
        status: map['status'] ?? '',
        notificationType: map['notification_type'] ?? '',
        docId: docId);
  }
}
