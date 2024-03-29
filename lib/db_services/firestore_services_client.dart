import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:uuid/uuid.dart';

class FireStoreServicesClient {
  static Uuid uid = const Uuid();
  static Future<void> createTickets(
      {required TicketModelClient ticketModel, required String docId}) async {
    FirebaseFirestore.instance
        .collection('tickets')
        .doc(docId)
        .set(ticketModel.toMap());
  }

  static Future<void> createChatSystem(
      {required CommentModel commentModel, required String docId}) async {
    FirebaseFirestore.instance
        .collection('tickets')
        .doc(docId)
        .collection('offers')
        .doc()
        .set(commentModel.toMap(), SetOptions(merge: true));
  }

  static Future<void> storeNotifications(
      {required NotificationModel notificationModel,
      required String name}) async {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(name)
        .collection(name)
        .doc()
        .set(notificationModel.toMap());
  }

  static Future<void> updateNotifications(
      {required String? docId, required String name}) async {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(name)
        .collection(name)
        .doc(docId)
        .update({'status': 'read'});
  }

  static Future<void> deleteReadNotifications({required String name}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('notifications')
        .doc(name)
        .collection(name)
        .where('user_id', isEqualTo: AuthServices.getCurrentUser.uid)
        .where('status', isEqualTo: 'read')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }

  static Future<void> saveSoldTicketsData({
    required TicketsSoldModel soldModel,
    required String hashKey,
    required String sellerUid,
    required String buyerUid,
  }) async {
    FirebaseFirestore.instance.collection('tickets_sold').doc(hashKey).set({
      'buyer_uid': buyerUid,
      'seller_uid': sellerUid,
    }).then((_) {
      return FirebaseFirestore.instance
          .collection('tickets_sold')
          .doc(hashKey)
          .collection('tickets_sold')
          .doc(uid.v4())
          .set(soldModel.toMap(), SetOptions(merge: true));
    });
  }

  static Future<void> updateStatusInSoldTicketsCollection({
    required String hashKey,
    required List<String> selectedDocIds,
    required String newStatus,
  }) async {
    final CollectionReference soldTicketsCollection = FirebaseFirestore.instance
        .collection('tickets_sold')
        .doc(hashKey)
        .collection('tickets_sold');
    for (String docId in selectedDocIds) {
      await soldTicketsCollection.doc(docId).update({'status': newStatus});
    }
  }

  static Future<Map<String, String>> fetchBuyerAndSellerUIDs(
      String hashKey) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('tickets_sold')
        .doc(hashKey)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      String buyerUid = data['buyer_uid'];
      String sellerUid = data['seller_uid'];

      return {'buyer_uid': buyerUid, 'seller_uid': sellerUid};
    } else {
      throw Exception('Snapshot does not exist');
    }
  }

  static Stream<List<TicketsSoldModel>> fetchSoldTicketsData({
    required String hashKey,
  }) {
    return FirebaseFirestore.instance
        .collection('tickets_sold')
        .doc(hashKey)
        .collection('tickets_sold')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TicketsSoldModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  static Stream<List<NotificationModel>> fetchNotifications(
      {required String? status}) {
    return FirebaseFirestore.instance
        .collection('notifications')
        .doc('client_notifications')
        .collection('client_notifications')
        .where('user_id', isEqualTo: AuthServices.getCurrentUser.uid)
        .where('status', isEqualTo: status)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return NotificationModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  static Future<void> verifyInstagram({required String instagram}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference user = firestore
          .collection('user_data')
          .doc(AuthServices.getCurrentUser.uid);

      await user.set(
        {
          'instagram_username': instagram,
          'profile_levels': {
            'isInstaVerified': true,
          },
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      log('Error storing user instagram: ${e.toString()}');
    }
  }

  static Stream<List<EventModalClient>> fetchEventData() {
    return FirebaseFirestore.instance
        .collection('event')
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return EventModalClient.fromMap(
          doc.data(),
        );
      }).toList();
    });
  }

  static Stream<EventModalClient> fetchEventDataBasedOnId(
      {required String eventId}) {
    return FirebaseFirestore.instance
        .collection('event')
        .doc(eventId)
        .snapshots()
        .map((event) {
      return EventModalClient.fromMap(event.data() ?? {});
    });
  }

  static Stream<List<TicketModelClient>> fetchTicketsData(
      {required String docID}) {
    return FirebaseFirestore.instance
        .collection('tickets')
        .where('event_id', isEqualTo: docID)
        .where('status', isEqualTo: 'Active')
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return TicketModelClient.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  static Stream<List<CommentModel>> fetchCommentsData({required String docId}) {
    return FirebaseFirestore.instance
        .collection('tickets')
        .doc(docId)
        .collection('offers')
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return CommentModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  static Future<void> updateCommentsData(
      {required String docId, required String offerId}) async {
    FirebaseFirestore.instance
        .collection('tickets')
        .doc(docId)
        .collection('offers')
        .doc(offerId)
        .update({'status': 'Confirm'});
  }

  static Stream<int> fetchCommentUserLength({required String docId}) {
    return FirebaseFirestore.instance
        .collection('tickets')
        .doc(docId)
        .collection('offers')
        .where('user_id', isEqualTo: AuthServices.getCurrentUser.uid)
        .snapshots()
        .map((event) => event.docs.length);
  }

  static Stream<UserModelClient> fetchUserLevels() {
    return FirebaseFirestore.instance
        .collection('user_data')
        .doc(AuthServices.getCurrentUser.uid)
        .snapshots()
        .map((event) {
      return UserModelClient.fromMap(event.data()!, event.id);
    });
  }

  static Future<void> storeFeedback(
      {required FeedbackModel feedbackModel, required String sellerId}) async {
    await FirebaseFirestore.instance
        .collection('feedback')
        .doc('feedback')
        .collection(sellerId)
        .doc(uid.v4())
        .set(feedbackModel.toMap());
  }

  static Stream<List<FeedbackModel>> fetchFeedback() {
    return FirebaseFirestore.instance
        .collection('feedback')
        .doc('feedback')
        .collection('fFacXp2HByTVd7jdQU78mF75JHY2')
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return FeedbackModel.fromMap(doc.data());
      }).toList();
    });
  }

  static Future<Map<String, dynamic>> calculateAverages(
      List<FeedbackModel>? feedbackList) async {
    if (feedbackList == null || feedbackList.isEmpty) {
      return {
        'rating': 0.0,
        'experience': '',
        'arrival_time': '',
        'communication_response': '',
      };
    }

    int totalRating = 0;
    int totalCount = 0;
    Map<String, int> experienceCount = {};
    Map<String, int> arrivalTimeCount = {};
    Map<String, int> communicationResponseCount = {};

    for (FeedbackModel feedback in feedbackList) {
      if (feedback.rating != null) {
        totalRating += feedback.rating!;
        totalCount++;
      }
      // Count occurrences of experience
      if (feedback.experience != null && feedback.experience!.isNotEmpty) {
        experienceCount.update(feedback.experience!, (value) => value + 1,
            ifAbsent: () => 1);
      }
      // Count occurrences of arrivalTime
      if (feedback.arrivalTime != null && feedback.arrivalTime!.isNotEmpty) {
        arrivalTimeCount.update(feedback.arrivalTime!, (value) => value + 1,
            ifAbsent: () => 1);
      }
      // Count occurrences of communicationResponse
      if (feedback.communicationResponse != null &&
          feedback.communicationResponse!.isNotEmpty) {
        communicationResponseCount.update(
            feedback.communicationResponse!, (value) => value + 1,
            ifAbsent: () => 1);
      }
    }

    double averageRating = totalCount > 0 ? totalRating / totalCount : 0.0;

    // Get most repeated experience
    String mostRepeatedExperience = experienceCount.entries.fold(
        '',
        (prev, entry) =>
            entry.value > (experienceCount[prev] ?? 0) ? entry.key : prev);

    // Get most repeated arrivalTime
    String mostRepeatedArrivalTime = arrivalTimeCount.entries.fold(
        '',
        (prev, entry) =>
            entry.value > (arrivalTimeCount[prev] ?? 0) ? entry.key : prev);

    // Get most repeated communicationResponse
    String mostRepeatedCommunicationResponse =
        communicationResponseCount.entries.fold(
            '',
            (prev, entry) =>
                entry.value > (communicationResponseCount[prev] ?? 0)
                    ? entry.key
                    : prev);

    return {
      'rating': averageRating,
      'experience': mostRepeatedExperience,
      'arrival_time': mostRepeatedArrivalTime,
      'communication_response': mostRepeatedCommunicationResponse,
    };
  }

  static Stream<UserModelClient> fetchUserData({required String userId}) {
    return FirebaseFirestore.instance
        .collection('user_data')
        .doc(userId)
        .snapshots()
        .map((event) {
      return UserModelClient.fromMap(event.data() ?? {}, event.id);
    });
  }

  static Future<UserModelClient> fetchDataOfUser(
      {required String userId}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('user_data')
        .doc(userId)
        .get();

    return UserModelClient.fromMap(snapshot.data() ?? {}, snapshot.id);
  }

  static Future<bool> checkUserEmail({required String email}) async {
    log("....................Email.............$email");
    var user = await FirebaseFirestore.instance
        .collection('user_data')
        .where("email", isEqualTo: email)
        .get();
    if (user.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static String getMessagesHashCodeID({required String userIDReceiver}) {
    String currentUserUID = AuthServices.getCurrentUser.uid;
    String chatHashID = '';
    if (currentUserUID.hashCode <= userIDReceiver.hashCode) {
      chatHashID = '$currentUserUID-$userIDReceiver';
    } else {
      chatHashID = '$userIDReceiver-$currentUserUID';
    }
    return chatHashID;
  }

  static Future<void> createMessageChat(
      {required MessageModel messageModel, required String hashKey}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference chatMessage = firestore
          .collection('chat_system')
          .doc('messages')
          .collection(hashKey)
          .doc();

      await chatMessage.set(
        messageModel.toMap(),
      );
    } catch (e) {
      log('Error storing ticket seller data: ${e.toString()}');
    }
  }

  static Stream<List<MessageModel>> getMessagesChat(String hashKey) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference messagesCollection =
        firestore.collection('chat_system').doc('messages').collection(hashKey);

    return messagesCollection
        .orderBy('time', descending: false)
        .snapshots()
        .map(
      (QuerySnapshot snapshot) {
        return snapshot.docs
            .map((doc) =>
                MessageModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      },
    );
  }

  static Stream<List<String>> getUsersConnections() {
    final currentUserUid = AuthServices.getCurrentUser.uid;

    return FirebaseFirestore.instance
        .collection('chat_system')
        .doc('connection')
        .collection('connection')
        .doc(currentUserUid)
        .snapshots()
        .map((documentSnapshot) {
      if (documentSnapshot.exists) {
        List<String> userIds =
            List<String>.from(documentSnapshot.data()?['connection'] ?? []);
        return userIds;
      } else {
        return [];
      }
    });
  }

  static Future<void> makeConnection({required String userIDReceiver}) async {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    try {
      if (currentUserID.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('chat_system')
            .doc('connection')
            .collection('connection')
            .doc(currentUserID)
            .set({
          'connection': FieldValue.arrayUnion([userIDReceiver])
        }, SetOptions(merge: true));
        await FirebaseFirestore.instance
            .collection('chat_system')
            .doc('connection')
            .collection('connection')
            .doc(userIDReceiver)
            .set({
          'connection': FieldValue.arrayUnion(
            [currentUserID],
          )
        }, SetOptions(merge: true));
      }
    } catch (e) {
      log('Error making connection between users : ${e.toString()}');
    }
  }
}
