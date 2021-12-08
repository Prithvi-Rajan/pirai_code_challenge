import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pirai_code_challenge/main.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:pirai_code_challenge/services/utilitiy_functions.dart';
import 'package:provider/provider.dart';

class FirebaseAuthService {
  static final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;
  static void loginWithEmailAndPassword(
      {required String email, required String password}) async {
    await auth.setPersistence(Persistence.SESSION);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final currentUser = userCredential.user;

      Provider.of<UserModel>(navigatorKey.currentState!.context, listen: false)
          .currentUser = currentUser;
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message ?? '');
    }
  }

  static void signupWithEmailAndPassword(
      {required String email,
      required String password,
      required name,
      required BuildContext context}) async {
    await auth.setPersistence(Persistence.SESSION);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var currentUser = userCredential.user;
      if (currentUser != null) {
        await currentUser.updateDisplayName(name);
        currentUser = auth.currentUser ?? currentUser;
        Provider.of<UserModel>(navigatorKey.currentState!.context,
                listen: false)
            .currentUser = currentUser;
        await db.collection('users').doc(currentUser.uid).set({
          'uid': currentUser.uid,
          'name': name,
          'email': email,
        });
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message ?? '');
    }
  }

  static Future<void> sendRecoveryMail({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      showSnackBar("Password recovery link sent to $email!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar('No user found for that email.');
      }
    }
  }

  static void signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      showSnackBar(e.toString());
    }
  }
}
