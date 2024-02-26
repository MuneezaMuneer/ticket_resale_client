class EventModelAdmin {
  String? festivalName;
  String? ticketType;
  String? price;
  String? date;
  String? status;
  String? userID;
  String? id;
  EventModelAdmin(
      {this.festivalName,
      this.ticketType,
      this.price,
      this.date,
      this.status,
      this.userID,
      this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'festivalName': festivalName,
      'ticketType': ticketType,
      'price': price,
      'date': date,
      'status': status,
      'id': userID,
    };
  }

  factory EventModelAdmin.fromMap(Map<String, dynamic> map, String docID) {
    return EventModelAdmin(
        festivalName: map['festival_name'] ?? '',
        ticketType: map['ticket_type'] ?? '',
        price: map['price'] ?? '',
        date: map['date'] ?? '',
        status: map['status'] ?? '',
        userID: map['user_id'] ?? '',
        id: docID);
  }
}
