import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:pirai_code_challenge/services/utilitiy_functions.dart';
import 'package:provider/provider.dart';
import 'package:pirai_code_challenge/main.dart';

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
      if (e.code == 'user-not-found') {
        showSnackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar('Wrong password provided for that user.');
      } else {
        showSnackBar(e.message);
      }
    }
  }

  static void signupWithEmailAndPassword(
      {required String email, required String password, required name}) async {
    await auth.setPersistence(Persistence.SESSION);
    try {
      await Provider.of<UserModel>(navigatorKey.currentState!.context,
              listen: false)
          .cancelListener();

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var currentUser = userCredential.user;
      if (currentUser != null) {
        await currentUser.updateDisplayName(name);
        currentUser = auth.currentUser!;
        await db.collection('users').doc(currentUser.uid).set({
          'uid': currentUser.uid,
          'name': currentUser.displayName,
          'email': currentUser.email,
        });
        Provider.of<UserModel>(navigatorKey.currentState!.context,
            listen: false)
          ..currentUser = currentUser
          ..addAuthStateListener();
      }
    } catch (e) {
      showSnackBar(e.toString());
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
