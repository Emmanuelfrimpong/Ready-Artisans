import 'package:flutter/material.dart';
import '../Models/Users/users.dart';

class UserProvider extends ChangeNotifier {
  Users? _user = Users();
  Users? get user => _user;
  void setUser(Users? user) {
    _user = user;
    notifyListeners();
  }
}
