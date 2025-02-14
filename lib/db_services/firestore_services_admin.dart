import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_resale/models/models.dart';

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

  static Stream<List<NotificationModel>> fetchNotification(
      {required String status}) {
    return fireStore
        .collection('notifications')
        .doc('admin_notifications')
        .collection('admin_notifications')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((query) {
      return query.docs
          .map((doc) => NotificationModel.fromMap(doc.data(), doc.id))
          .toList();
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
        .doc('admin_token_for_mob')
        .set({'token': token});
  }

  static Stream<List<TicketModalAdmin>> fetchTicket() async* {
    var ticketsCollection = FirebaseFirestore.instance.collection('tickets');

    // Map to store event and user data
    Map<String, dynamic> eventDataMap = {};
    Map<String, dynamic> userDataMap = {};

    // Listen for changes in the tickets collection
    await for (var snapshot in ticketsCollection.snapshots()) {
      List<TicketModalAdmin> ticketsList = [];

      if (snapshot.docs.isNotEmpty) {
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
              fcmtoken: userDataMap[userID]['fcm_token'],
              eventid: eventID,
              userId: userID));
        }

        // Yield the updated list
        yield List.from(ticketsList);
      } else {
        yield List.from(ticketsList);
      }
    }
  }

  static Future<void> deleteReadNotifications({required String name}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('notifications')
        .doc(name)
        .collection(name)
        .where('status', isEqualTo: 'read')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }
}
