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
          .map((doc) => EventModelAdmin.fromMap(doc.data()))
          .toList();
    });
  }
}
