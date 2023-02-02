import 'package:chat/database_utils/database_utils.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/ui/screens/base.dart';
import 'package:chat/ui/screens/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;
  String message = "";

  void login(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser? myUser = await DataBaseUtils.readUserFromFirestore(credential.user?.uid ?? "");
      message = "Successfully logged";
      if (myUser != null) {
        navigator!.hideLoading();
        navigator!.goToHome(myUser);
        return;
      }

    } on FirebaseAuthException catch (e) {
      message = "wrong email or password";
    } catch (e) {
      message = "Something went wrong${e.toString()}";
    }
    if (message != "") {
      navigator!.hideLoading();
      navigator!.showMessage(message);
    }
  }
}