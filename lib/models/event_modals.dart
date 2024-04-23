class EventModalClient {
  String? imageUrl;
  String? eventName;
  String? date;
  String? description;
  String? docId;
  String? time;
  String? location;
  bool? featuredEvent;

  EventModalClient(
      {this.imageUrl,
      this.eventName,
      this.date,
      this.description,
      this.docId,
      this.time,
      this.location,
      this.featuredEvent});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isFeatured': featuredEvent,
      'image_url': imageUrl,
      'event_name': eventName,
      'date': date,
      'description': description,
      'doc_id': docId,
      'time': time,
      'location': location,
    };
  }

  factory EventModalClient.fromMap(
    Map<String, dynamic> map,
  ) {
    return EventModalClient(
      featuredEvent: map['isFeatured'] ?? '',
      imageUrl: map['image_url'] ?? '',
      eventName: map['event_name'] ?? '',
      date: map['date'] ?? '',
      description: map['description'] ?? '',
      docId: map['doc_id'] ?? '',
      time: map['time'] ?? '',
      location: map['location'] ?? '',
    );
  }
}

class EventModelAdmin {
  String? festivalName;
  String? ticketType;
  String? price;
  String? date;
  String? status;
  String? userID;
  String? id;
  String? username;

  EventModelAdmin(
      {this.festivalName,
      this.ticketType,
      this.price,
      this.date,
      this.status,
      this.userID,
      this.username,
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
        username: map['user_name'] ?? '',
        date: map['date'] ?? '',
        status: map['status'] ?? '',
        userID: map['user_id'] ?? '',
        id: docID);
  }
}
