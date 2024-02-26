import 'dart:developer';

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
 static Stream<List<UserModel>> fetchUserLevels() {
    return FirebaseFirestore.instance
        .collection('user_data')
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        return UserModel.fromMap(doc.data());
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
