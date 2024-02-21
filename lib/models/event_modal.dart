class EventModal {
  String? imageUrl;
  String? festivalName;
  String? ticketType;
  String? date;
  String? price;
  String? description;
  String? userId;
  EventModal({
    this.imageUrl,
    this.festivalName,
    this.ticketType,
    this.date,
    this.price,
    this.description,
    this.userId,
  });

  EventModal copyWith({
    String? imageUrl,
    String? festivalName,
    String? ticketType,
    String? date,
    String? price,
    String? description,
    String? userId,
  }) {
    return EventModal(
      imageUrl: imageUrl ?? this.imageUrl,
      festivalName: festivalName ?? this.festivalName,
      ticketType: ticketType ?? this.ticketType,
      date: date ?? this.date,
      price: price ?? this.price,
      description: description ?? this.description,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_url': imageUrl,
      'festival_name': festivalName,
      'ticket_type': ticketType,
      'date': date,
      'price': price,
      'description': description,
      'user_id': userId,
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
    );
  }
}
