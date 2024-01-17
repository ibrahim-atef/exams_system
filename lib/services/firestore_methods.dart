import 'package:cloud_firestore/cloud_firestore.dart';

import '../utilites/my_strings.dart';

class FireStoreMethods {



  Future<void> insertStudentsInfoFireStorage(
    String displayName,
    email,
    uid,
      role,
  ) async {
    FirebaseFirestore.instance.collection(role).doc(uid).set({
      'displayName': displayName,
      'uid': uid,
      'email': email,
      'role':role,
      "registerDate": DateTime.now(),
    });
    return;
  }
}
