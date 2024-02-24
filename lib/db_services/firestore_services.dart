import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:uuid/uuid.dart';

class FireStoreServices {
  static Uuid uid = const Uuid();
  static Future<void> uploadEventData({required EventModal eventModal}) async {
    FirebaseFirestore.instance
        .collection('event_ticket')
        .doc(uid.v4())
        .set(eventModal.toMap());
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
}
