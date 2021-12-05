import 'package:firebase_auth/firebase_auth.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:pirai_code_challenge/services/utilitiy_functions.dart';
import 'package:provider/provider.dart';
import 'package:pirai_code_challenge/main.dart';

class FirebaseAuthService {
  static final auth = FirebaseAuth.instance;
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
      }
    }
  }

  static void signupWithEmailAndPassword(
      {required String email, required String password, required name}) async {
    await auth.setPersistence(Persistence.SESSION);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final currentUser = userCredential.user;
      if (currentUser != null) {
        await currentUser.updateDisplayName(name);
        Provider.of<UserModel>(navigatorKey.currentState!.context,
                listen: false)
            .currentUser = currentUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar('Wrong password provided for that user.');
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
