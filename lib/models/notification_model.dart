import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? title;
  String? body;
  Timestamp? time;
  String? notificationType;
  String? eventId;
  String? userId;
  String? status;
  String? docId;
  String? ticketId;
  String? price;
  NotificationModel(
      {this.title,
      this.body,
      this.time,
      this.eventId,
      this.userId,
      this.status,
      this.notificationType,
      this.ticketId,
      this.price,
      this.docId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'time': FieldValue.serverTimestamp(),
      'event_id': eventId,
      'user_id': userId,
      'status': status,
      'notification_type': notificationType,
      'ticket_id': ticketId,
      'price': price
    };
  }

  Map<String, dynamic> toMapForNotifications() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'event_id': eventId,
      'user_id': userId,
      'status': status,
      'notification_type': notificationType,
      'ticket_id': ticketId,
      'price': price
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map, String docId) {
    return NotificationModel(
        title: map['title'] ?? '',
        body: map['body'] ?? '',
        time: map['time'] ?? Timestamp.now(),
        eventId: map['event_id'] ?? '',
        userId: map['user_id'] ?? '',
        status: map['status'] ?? '',
        notificationType: map['notification_type'] ?? '',
        ticketId: map['ticket_id'] ?? '',
        price: map['price'] ?? '',
        docId: docId);
  }
}
