class TicketModal {
  String? description;
  String? price;
  String? ticketType;
  String? status;
  String? ticketID;
  String? eventName;
  String? image;
  String? userName;
  String? fcmToken;

  TicketModal(
      {this.description,
      this.price,
      this.ticketType,
      this.ticketID,
      this.status,
      this.eventName,
      this.image,
      this.userName,
      this.fcmToken});

  factory TicketModal.fromMap({
    required Map<String, dynamic> map,
    required String ticketID,
    required String userName,
    required String eventName,
    // required String fcmtoken,
  }) {
    return TicketModal(
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
