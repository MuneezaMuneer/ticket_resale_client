import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_resale/admin_panel/event_model_admin.dart';

import 'user_model_admin.dart';

class FirestoreServices {
  static Stream<List<UserModelAdmin>> fetchUserData() {
    return FirebaseFirestore.instance
        .collection('user_data')
        .snapshots()
        .map((query) {
      return query.docs
          .map((doc) => UserModelAdmin.fromMap(doc.data()))
          .toList();
    });
  }

  static Stream<List<EventModelAdmin>> fetchEvents() {
    return FirebaseFirestore.instance
        .collection('event_ticket')
        .snapshots()
        .map((query) {
      return query.docs
          .map((doc) => EventModelAdmin.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  static Future<void> updateStatus(
      String documentId, String currentStatus) async {
    String newValue = (currentStatus == 'Active') ? 'Disable' : 'Active';
    try {
      final docRef =
          FirebaseFirestore.instance.collection('event_ticket').doc(documentId);
      await docRef.update({'status': newValue});
    } catch (e) {
      print('Error updating status: $e');
    }
  }
}
