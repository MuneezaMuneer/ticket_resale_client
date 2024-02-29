import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:uuid/uuid.dart';

class FireStoreServices {
  static Uuid uid = const Uuid();
  static Future<void> createTickets(
      {required TicketModel ticketModel, required String id}) async {
    FirebaseFirestore.instance
        .collection('tickets')
        .doc('tickets')
        .collection(id)
        .doc(uid.v4())
        .set(ticketModel.toMap());
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

  static Stream<List<EventModal>> fetchEventData() {
    return FirebaseFirestore.instance
        .collection('event_ticket')
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return EventModal.fromMap(doc.data());
      }).toList();
    });
  }

  static Stream<List<TicketModel>> fetchTicketsData({required String docID}) {
    return FirebaseFirestore.instance
        .collection('tickets')
        .doc('tickets')
        .collection(docID)
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return TicketModel.fromMap(doc.data());
      }).toList();
    });
  }

  static Stream<List<UserModel>> fetchUserLevels() {
    return FirebaseFirestore.instance
        .collection('user_data')
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return UserModel.fromMap(doc.data(), doc.id);
      }).toList();
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
}
