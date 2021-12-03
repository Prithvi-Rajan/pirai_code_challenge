import 'package:firebase_auth/firebase_auth.dart';
import 'package:pirai_code_challenge/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:pirai_code_challenge/main.dart';

class FirebaseAuthService {
  static void loginWithEmailAndPassword(
      {required String email, required String password}) async {
    final auth = FirebaseAuth.instance;
    await auth.setPersistence(Persistence.SESSION);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final currentUser = userCredential.user;

      Provider.of<UserModel>(navigatorKey.currentState!.context, listen: false)
          .currentUser = currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static void signupWithEmailAndPassword(
      {required String email, required String password, required name}) async {
    final auth = FirebaseAuth.instance;
    await auth.setPersistence(Persistence.SESSION);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final currentUser = userCredential.user;
      if (currentUser != null) {
        currentUser.updateDisplayName(name);
        Provider.of<UserModel>(navigatorKey.currentState!.context,
                listen: false)
            .currentUser = currentUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
