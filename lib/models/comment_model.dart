import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? userId;
  DateTime? time; 
  String? offerPrice;
  String? comment;

  CommentModel({
    this.userId,
    required this.time, 
    this.offerPrice,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'time': FieldValue.serverTimestamp(),
      'offer_price': offerPrice,
      'comment': comment,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    Timestamp? time =  map['time'];
    final dateTime = time!.toDate(); 
    return CommentModel(
      userId: map['user_id'] ?? '',
     time: dateTime, 
      offerPrice: map['offer_price'] ?? '',
      comment: map['comment'] ?? '',
    );
  }
}
