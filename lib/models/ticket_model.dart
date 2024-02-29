class TicketModel {
  String? imageUrl;
  String? ticketType;
  String? price;
  String? description;
  String? status;
  String? uid;
  TicketModel({
    this.imageUrl,
    this.status,
    this.ticketType,
    this.price,
    this.description,
    this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_url': imageUrl,
      'status': status,
      'ticket_type': ticketType,
      'price': price,
      'description': description,
      'uid': uid
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
        imageUrl: map['image_url'] ?? '',
        ticketType: map['ticket_type'] ?? '',
        price: map['price'] ?? '',
        description: map['description'] ?? '',
        status: map['status'] ?? '',
        uid: map['uid'] ?? '');
  }
}
