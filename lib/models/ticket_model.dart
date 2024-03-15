class TicketModel {
  String? imageUrl;
  String? ticketType;
  String? price;
  String? description;
  String? status;
  String? uid;
  String? eventId;
  String? docId;
  TicketModel(
      {this.imageUrl,
      this.status,
      this.ticketType,
      this.price,
      this.description,
      this.uid,
      this.eventId,
      this.docId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_url': imageUrl,
      'status': status,
      'ticket_type': ticketType,
      'price': price,
      'description': description,
      'user_uid': uid,
      'event_id': eventId
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map, String docId) {
    return TicketModel(
      imageUrl: map['image_url'] ?? '',
      ticketType: map['ticket_type'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? '',
      uid: map['user_uid'] ?? '',
      eventId: map['event_id'] ?? '',
      docId: docId
    );
  }
}
