class EventModal {
  String? imageUrl;
  String? festivalName;
  String? ticketType;
  String? date;
  String? price;
  String? description;
  String? userId;
  String? time;
  String? status;

  EventModal({
    this.imageUrl,
    this.festivalName,
    this.ticketType,
    this.date,
    this.price,
    this.description,
    this.userId,
    this.time,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_url': imageUrl,
      'festival_name': festivalName,
      'ticket_type': ticketType,
      'date': date,
      'price': price,
      'description': description,
      'user_id': userId,
      'time': time,
      'status': status
    };
  }

  factory EventModal.fromMap(Map<String, dynamic> map) {
    return EventModal(
        imageUrl: map['image_url'] ?? '',
        festivalName: map['festival_name'] ?? '',
        ticketType: map['ticket_type'] ?? '',
        date: map['date'] ?? '',
        price: map['price'] ?? '',
        description: map['description'] ?? '',
        userId: map['user_id'] ?? '',
        time: map['time'] ?? '',
        status: map['status'] ?? '');
  }
}
