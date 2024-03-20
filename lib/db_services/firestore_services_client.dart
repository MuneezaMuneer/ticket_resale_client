import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/message_model.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:uuid/uuid.dart';
import '../models/ticket_model.dart';

class FireStoreServicesClient {
  static Uuid uid = const Uuid();
  static Future<void> createTickets({required TicketModel ticketModel}) async {
    FirebaseFirestore.instance
        .collection('tickets')
        .doc(uid.v4())
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

  static Stream<List<TicketModel>> fetchTicketsData({required String docID}) {
    return FirebaseFirestore.instance
        .collection('tickets')
        .where('event_id', isEqualTo: docID)
        .where('status', isEqualTo: 'Active')
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return TicketModel.fromMap(doc.data(), doc.id);
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

  static Stream<List<UserModelClient>> fetchUserLevels() {
    return FirebaseFirestore.instance
        .collection('user_data')
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return UserModelClient.fromMap(doc.data(), doc.id);
      }).toList();
    });
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
