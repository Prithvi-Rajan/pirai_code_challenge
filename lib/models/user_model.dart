import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pirai_code_challenge/main.dart';
import 'package:pirai_code_challenge/views/LoginFlow/login.dart';
import 'package:pirai_code_challenge/views/home.dart';

class UserModel extends ChangeNotifier {
  User? _currentUser;

  StreamSubscription<User?>? _authStream;

  User? get currentUser {
    if (_currentUser == null) return null;
    return _currentUser;
  }

  set currentUser(User? value) {
    _currentUser = value;
    notifyListeners();
  }

  Future<void> addAuthStateListener() async {
    await _authStream?.cancel();
    _authStream = FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        _currentUser = event;
        notifyListeners();
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(LoginView.routeName, (route) => false);
      } else {
        _currentUser = event;
        notifyListeners();
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(Home.routeName, (route) => false);
      }
    });
  }
}
