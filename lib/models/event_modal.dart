class EventModal {
  String? imageUrl;
  String? festivalName;
  String? date;
  String? description;
  String? docId;
  String? time;
  String? city;

  EventModal(
      {this.imageUrl,
      this.festivalName,
      this.date,
      this.description,
      this.docId,
      this.time,
      this.city});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_url': imageUrl,
      'festival_name': festivalName,
      'date': date,
      'description': description,
      'doc_id': docId,
      'time': time,
      'city': city,
    };
  }

  factory EventModal.fromMap(Map<String, dynamic> map) {
    return EventModal(
      imageUrl: map['image_url'] ?? '',
      festivalName: map['festival_name'] ?? '',
      date: map['date'] ?? '',
      description: map['description'] ?? '',
      docId: map['doc_id'] ?? '',
      time: map['time'] ?? '',
      city: map['city'] ?? '',
    );
  }
}
