import 'package:cloud_firestore/cloud_firestore.dart';

class TicketsSoldModel {
  String? ticketPrice;
  String? ticketName;
  DateTime? dateTime;
  String? ticketImage;
  String? status;
  String?  docId;
  TicketsSoldModel({
    this.status,
    this.ticketPrice,
    this.ticketName,
    this.dateTime,
    this.ticketImage,
    this.docId
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ticket_price': ticketPrice,
      'ticket_name': ticketName,
      'date_time': FieldValue.serverTimestamp(),
      'ticket_image': ticketImage,
      'status': status,
     
    };
  }

  factory TicketsSoldModel.fromMap(Map<String, dynamic> map,String docId) {
    Timestamp? time = map['date_time'];
    final dateTime = time!.toDate();
    return TicketsSoldModel(
        ticketPrice:
            map['ticket_price'] != null ? map['ticket_price'] as String : null,
        ticketName:
            map['ticket_name'] != null ? map['ticket_name'] as String : null,
        dateTime: dateTime,
        ticketImage:
            map['ticket_image'] != null ? map['ticket_image'] as String : null,
        status: map['status'] ?? '',
        docId: docId
        );
  }
}
