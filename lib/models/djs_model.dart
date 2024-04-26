class DjsModel {
  String? name;
  String? location;
  String? description;
  String? imageUrl;
  String? docId;
  DjsModel({
    this.name,
    this.location,
    this.description,
    this.imageUrl,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'location': location,
      'description': description,
      'image_url': imageUrl,
      'doc_id': docId,
    };
  }

  factory DjsModel.fromMap(Map<String, dynamic> map) {
    return DjsModel(
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['image_url'] ?? '',
      docId: map['doc_id'] ?? '',
    );
  }
}
