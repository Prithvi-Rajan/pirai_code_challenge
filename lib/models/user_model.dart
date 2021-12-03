import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pirai_code_challenge/main.dart';
import 'package:pirai_code_challenge/views/LoginFlow/login.dart';
import 'package:pirai_code_challenge/views/Products/product_view.dart';

class UserModel extends ChangeNotifier {
  late User? _currentUser;

  User? get currentUser {
    if (_currentUser == null) return null;
    return _currentUser;
  }

  set currentUser(User? value) {
    _currentUser = value;
    notifyListeners();
  }

  void addAuthStateListener() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(LoginView.routeName, (route) => false);
      } else {
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(ProductView.routeName, (route) => false);
      }
    });
  }
}
