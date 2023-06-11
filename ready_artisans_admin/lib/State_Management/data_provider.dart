import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans_admin/Models/Users/users_model.dart';

import '../Database/firebase_api.dart';

//create stream provider of users
final usersStreamProvider = StreamProvider<List<UsersModel>>((ref) async* {
  final Stream<QuerySnapshot> stream = FirebaseApi.getUsers();
  yield* stream.map((event) => event.docs
      .map((e) => UsersModel.fromMap(e.data() as Map<String, dynamic>))
      .toList());
});

final usersProvider = StateProvider<List<UsersModel>>((ref) {
  return [];
});
//? users search provider
final queryStringProvider = StateProvider<String>((ref) {
  return '';
});
final filterUserMap = StateProvider<List<Map<String, dynamic>>>((ref) {
  var data = ref.watch(usersProvider).map((e) => e.toMap()).toList();
  switch (ref.watch(queryStringProvider)) {
    case '':
      return data;
    default:
      return data
          .where((element) =>
              element['id']
                  .toLowerCase()
                  .contains(ref.watch(queryStringProvider).toLowerCase()) ||
              element['name']
                  .toLowerCase()
                  .contains(ref.watch(queryStringProvider).toLowerCase()) ||
              element['email']
                  .toLowerCase()
                  .contains(ref.watch(queryStringProvider).toLowerCase()) ||
              element['phone']
                  .toLowerCase()
                  .contains(ref.watch(queryStringProvider).toLowerCase()) ||
              element['status']
                  .toLowerCase()
                  .contains(ref.watch(queryStringProvider).toLowerCase()))
          .toList();
  }
});
