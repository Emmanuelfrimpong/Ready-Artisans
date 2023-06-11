import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_artisans_admin/Models/category_model.dart';

import '../Components/smart_dialog.dart';

class FirebaseApi {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.dismiss();
        CustomDialog.showError(
          title: 'Error',
            message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialog.dismiss();
        CustomDialog.showError(
          title: 'Error',
            message: 'Wrong password provided for that user.');
      }
    }
    return null;
  }

  static signOut() {
    _auth.signOut();
  }

  static Future<String?> uploadImage(XFile image, String id) async {
    final filePath = _firebaseStorage.ref('images/$id');
    var data = await image.readAsBytes();
    var upload = await filePath.putData(
        data, SettableMetadata(contentType: 'image/jpeg'));
    if (upload.state == TaskState.success) {
      return await filePath.getDownloadURL();
    }
    return null;

  }

  static Future<String> getId(String s) async {
    return _firestore.collection(s).doc().id;
  }

  static Future<Map<String, dynamic>?> addCategory(
      CategoryModel category) async {
    await _firestore
        .collection('Categories')
        .doc(category.id)
        .set(category.toMap())
        // ignore: void_checks
        .onError((error, stackTrace) {
      return {'message': error.toString(), 'status': false};
    });
    return {'status': true, 'message': 'Completed'};
  }

  static Future<bool> getCategoryByName(String s) async {
    var data = await _firestore
        .collection('Categories')
        .where('name', isEqualTo: s)
        .get();
    return data.docs.isNotEmpty;
  }

  static getCategories() {
    return _firestore.collection('Categories').snapshots();
  }

  static Future<Map<String, dynamic>>deleteCategory(String s)async {
    await _firestore.collection('Categories').doc(s).delete().then((value){
      return {'status':true,'message':'Deleted'};
    }).onError((error, stackTrace){
      return {'status':false,'message':error.toString()};
    });
    return {'status':true,'message':'Deleted'};
  }

  static deleteImage(String s) {
    final ref = _firebaseStorage.ref('images/$s');
    ref.delete();
  }

  static Stream<QuerySnapshot> getUsers() {
    return _firestore.collection('Users').snapshots();
  }
}
