class TicketModalAdmin {
  String? description;
  String? price;
  String? ticketType;
  String? status;
  String? ticketID;
  String? eventName;
  String? image;
  String? userName;
  String? fcmToken;

  TicketModalAdmin(
      {this.description,
      this.price,
      this.ticketType,
      this.ticketID,
      this.status,
      this.eventName,
      this.image,
      this.userName,
      this.fcmToken});

  factory TicketModalAdmin.fromMap({
    required Map<String, dynamic> map,
    required String ticketID,
    required String userName,
    required String eventName,
    // required String fcmtoken,
  }) {
    return TicketModalAdmin(
      description: map['description'] ?? '',
      price: map['price'] ?? '',
      ticketType: map['ticket_type'] ?? '',
      status: map['status'] ?? '',
      ticketID: ticketID,
      image: map['image_url'] ?? '',
      userName: userName,
      eventName: eventName,
      //  fcmToken: fcmtoken,
    );
  }
}

class TicketModelClient {
  String? imageUrl;
  String? ticketType;
  String? price;
  String? description;
  String? status;
  String? uid;
  String? eventId;
  String? docId;
  TicketModelClient(
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

  factory TicketModelClient.fromMap(Map<String, dynamic> map, String docId) {
    return TicketModelClient(
        imageUrl: map['image_url'] ?? '',
        ticketType: map['ticket_type'] ?? '',
        price: map['price'] ?? '',
        description: map['description'] ?? '',
        status: map['status'] ?? '',
        uid: map['user_uid'] ?? '',
        eventId: map['event_id'] ?? '',
        docId: docId);
  }
}
