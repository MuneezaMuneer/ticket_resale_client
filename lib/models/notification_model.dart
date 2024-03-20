import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? title;
  String? body;
  Timestamp? time;
  String? ticketId;
  String? userId;
  NotificationModel({
    this.title,
    this.body,
    this.time,
    this.ticketId,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'time': FieldValue.serverTimestamp(),
      'ticket_id': ticketId,
      'user_id': userId,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      time: map['time'] ?? Timestamp.now(),
      ticketId: map['ticket_id'] ?? '',
      userId: map['user_id'] ?? '',
    );
  }
}
