class CreateEvents {
  String? imageUrl;
  String? eventName;
  String? date;
  String? time;
  String? description;
  String? location;
  String? docID;
  String? eventID;
  CreateEvents(
      {this.imageUrl,
      this.eventName,
      this.date,
      this.time,
      this.description,
      this.location,
      this.docID});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_url': imageUrl,
      'event_name': eventName,
      'date': date,
      'time': time,
      'description': description,
      'location': location,
      'doc_id': docID,
    };
  }

  factory CreateEvents.fromMap(
    Map<String, dynamic> map,
  ) {
    return CreateEvents(
      imageUrl: map['image_url'] ?? '',
      eventName: map['event_name'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      docID: map['doc_id'],
    );
  }
}
