import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_resale/models/create_event.dart';
import '../models/tickets_model.dart';
import 'user_model_admin.dart';

class FirestoreServices {
  static final fireStore = FirebaseFirestore.instance;
  static Stream<List<UserModelAdmin>> fetchUserData() {
    return FirebaseFirestore.instance.collection('user_data').snapshots().map(
      (query) {
        return query.docs
            .map((doc) => UserModelAdmin.fromMap(doc.data(), doc.id))
            .toList();
      },
    );
  }

  static Future<List<TicketModel>> fetchTickets() async {
    var querySnapshot = await fireStore.collection('tickets').get();
    List<TicketModel> tickets = querySnapshot.docs
        .map((doc) => TicketModel.fromMap(map: doc.data(), ticketID: doc.id))
        .toList();

    return tickets;
  }

  static Future<void> updateStatus(String documentId, String newValue) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('event_ticket').doc(documentId);
      await docRef.update({'status': newValue});
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  static Future<void> updateUserStatus(
      String documentId, String newValue) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('user_data').doc(documentId);
      await docRef.update({'status': newValue});
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  static Stream<String> fetchTicketStatus({required String ticketID}) {
    var querySnapshot =
        fireStore.collection('tickets').doc(ticketID).snapshots();

    return querySnapshot.map((event) => event['status']);
  }

  static Future<void> updateTicketStatus(
      String documentId, String newValue) async {
    try {
      final docRef = fireStore.collection('tickets').doc(documentId);
      await docRef.update({'status': newValue});
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  static Stream<List<CreateEvents>> fetchEventData() {
    return fireStore.collection('event').snapshots().map((query) {
      return query.docs.map((doc) => CreateEvents.fromMap(doc.data())).toList();
    });
  }

  static Future<void> uploadEventData(
      {required CreateEvents createEvent, required String docId}) async {
    FirebaseFirestore.instance
        .collection('event')
        .doc(docId)
        .set(createEvent.toMap());
  }

  static Future<void> storeFCMToken({required String token}) async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('admin_data')
        .doc(userUID)
        .set({'fcm_token': token});
  }

  // fetch event name
  static Stream<String> fetchEventName({required String eventID}) {
    var querySnapshot = fireStore.collection('event').doc(eventID).snapshots();
    return querySnapshot.map((event) => event['event_name']);
  }

  // fetch user name
  static Stream<String> fetchUserName({required String userID}) {
    var querySnapshot =
        fireStore.collection('user_data').doc(userID).snapshots();

    return querySnapshot.map((event) => event['user_name']);
  }
}
