class TicketModel {
  String? description;
  String? price;
  String? ticketType;
  String? status;
  String? ticketID;
  String? eventID;
  String? image;
  String? userID;

  TicketModel({
    this.description,
    this.price,
    this.ticketType,
    this.ticketID,
    this.status,
    this.eventID,
    this.image,
    this.userID,
  });

  factory TicketModel.fromMap({
    required Map<String, dynamic> map,
    required String ticketID,
  }) {
    return TicketModel(
      description: map['description'] ?? '',
      price: map['price'] ?? '',
      ticketType: map['ticket_type'] ?? '',
      status: map['status'] ?? '',
      ticketID: ticketID,
      image: map['image_url'] ?? '',
      userID: map['user_uid'] ?? '',
      eventID: map['event_id'] ?? '',
    );
  }
}
