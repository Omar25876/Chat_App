import 'package:chat/shared/components/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login {

  void SignInWithFirebase(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseErrors.userNotFound) {
        print('No user found for that email.');
      } else if (e.code == FireBaseErrors.wrongPassword) {
        print('Wrong password provided for that user.');
      }
    }
  }
}