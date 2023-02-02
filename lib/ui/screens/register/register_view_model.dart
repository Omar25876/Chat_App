import 'package:chat/database_utils/database_utils.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/shared/components/firebase_errors.dart';
import 'package:chat/ui/screens/base.dart';
import 'package:chat/ui/screens/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  String message = "";
  CreateAccountWithFireBaseAuth(
      String name, String email, String password) async {
    try {
      navigator!.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      MyUser myUser =
          MyUser(id: credential.user?.uid ?? "", name: name, email: email);

      DataBaseUtils.addUserToFirestore(myUser).then((value) {
        navigator!.hideLoading();
        navigator!.goToHome(myUser);
        return;
      });

      message = "Successfully Created";
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseErrors.weakPassword) {
        message = "The password provided is too weak.";
      } else if (e.code == FireBaseErrors.emailAlreadyInUse) {
        message = "The account already exists for that email.";
      }
    } catch (e) {
      message = "Something went wrong${e.toString()}";
    }
    if (message != "") {
      navigator!.hideLoading();
      navigator!.showMessage(message);
    }
  }
}
