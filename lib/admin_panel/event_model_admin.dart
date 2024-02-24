class EventModelAdmin {
  String? festivalName;
  String? ticketType;
  String? price;
  String? date;
  EventModelAdmin({
    this.festivalName,
    this.ticketType,
    this.price,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'festivalName': festivalName,
      'ticketType': ticketType,
      'price': price,
      'date': date,
    };
  }

  factory EventModelAdmin.fromMap(Map<String, dynamic> map) {
    return EventModelAdmin(
      festivalName: map['festival_name'] ?? '',
      ticketType: map['ticket_type'] ?? '',
      price: map['price'] ?? '',
      date: map['date'] ?? '',
    );
  }
}
