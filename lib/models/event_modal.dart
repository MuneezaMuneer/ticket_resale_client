class EventModal {
  String? imageUrl;
  String? eventName;
  String? date;
  String? description;
  String? docId;
  String? time;
  String? location;
 

  EventModal(
      {this.imageUrl,
      this.eventName,
      this.date,
      this.description,
      this.docId,
      this.time,
      this.location
     });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_url': imageUrl,
      'event_name': eventName,
      'date': date,
      'description': description,
      'doc_id': docId,
      'time': time,
      'location': location,
    };
  }

  factory EventModal.fromMap(Map<String, dynamic> map, ) {
    return EventModal(
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
