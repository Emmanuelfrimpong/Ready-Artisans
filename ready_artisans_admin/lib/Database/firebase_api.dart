import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Components/smart_dialog.dart';

class FirebaseApi {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.dismiss();
        CustomDialog.showError(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialog.dismiss();
        CustomDialog.showError(
            message: 'Wrong password provided for that user.');
      }
    }
    return null;
  }

  static signOut() {
    _auth.signOut();
  }
}
