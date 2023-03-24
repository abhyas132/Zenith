import 'package:flutter/material.dart';
import 'package:zenith/models/user_modal.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    userId: '',
    name: '',
    email: '',
    password: '',
    zenCoins: 0,
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
