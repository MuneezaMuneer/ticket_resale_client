class FeedbackModel {
  final int? rating;
  final String? comment;
  final String? experience;
  final String? arrivalTime;
  final String? accurateInfo;
  final String? communicationResponse;
  final String? buyerId;
  final String? sellerId;
  FeedbackModel({
    this.rating,
    this.comment,
    this.experience,
    this.arrivalTime,
    this.accurateInfo,
    this.communicationResponse,
    this.buyerId,
    this.sellerId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'comment': comment,
      'experience': experience,
      'arrival_time': arrivalTime,
      'accurate_info': accurateInfo,
      'communication_response': communicationResponse,
      'buyer_id': buyerId,
      'seller_id': sellerId,
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      rating: map['rating'] ?? '',
      comment: map['comment'] ?? '',
      experience: map['experience'] ?? '',
      arrivalTime: map['arrival_time'] ?? '',
      accurateInfo: map['accurate_info'] ?? '',
      communicationResponse: map['communication_response'] ?? '',
      buyerId: map['buyer_id'] ?? '',
      sellerId: map['seller_id'] ?? '',
    );
  }
}
