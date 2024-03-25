import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class FirestoreServicesAdmin {
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
    FirebaseFirestore.instance
        .collection('admin_data')
        .doc('admin_token')
        .set({'fcm_token': token});
  }

  static Stream<List<TicketModalAdmin>> fetchTicket() async* {
    var ticketsCollection = FirebaseFirestore.instance.collection('tickets');

    // Map to store event and user data
    Map<String, dynamic> eventDataMap = {};
    Map<String, dynamic> userDataMap = {};

    // Listen for changes in the tickets collection
    await for (var snapshot in ticketsCollection.snapshots()) {
      List<TicketModalAdmin> ticketsList = [];

      // Fetch event and user data in batches
      var eventIDs = snapshot.docs
          .map((ticketData) => ticketData['event_id'].toString())
          .toList();
      var userIDs = snapshot.docs
          .map((ticketData) => ticketData['user_uid'].toString())
          .toList();

      var eventSnapshots = await FirebaseFirestore.instance
          .collection('event')
          .where(FieldPath.documentId, whereIn: eventIDs)
          .get();
      var userSnapshots = await FirebaseFirestore.instance
          .collection('user_data')
          .where(FieldPath.documentId, whereIn: userIDs)
          .get();

      // Update event and user data maps
      for (var eventDoc in eventSnapshots.docs) {
        eventDataMap[eventDoc.id] = eventDoc.data();
      }

      for (var userDoc in userSnapshots.docs) {
        userDataMap[userDoc.id] = userDoc.data();
      }

      // Build ticket models
      for (var ticketData in snapshot.docs) {
        String eventID = ticketData['event_id'].toString();
        String userID = ticketData['user_uid'].toString();

        // Build ticket model and add to the list
        ticketsList.add(TicketModalAdmin.fromMap(
          map: ticketData.data(),
          ticketID: ticketData.id,
          eventName: eventDataMap[eventID]['event_name'],
          userName: userDataMap[userID]['user_name'],
          //  fcmtoken: userDataMap[userID]['fcm_token'],
        ));
      }

      // Yield the updated list
      yield List.from(ticketsList);
    }
  }
}
