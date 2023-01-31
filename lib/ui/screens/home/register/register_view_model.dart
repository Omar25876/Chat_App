import 'package:chat/shared/components/firebase_errors.dart';
import 'package:chat/ui/screens/home/register/connector_between_view_viewmodal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class RegisterViewModel extends ChangeNotifier {
  late Connector connector;
  CreateAccountWithFireBaseAuth(String emailAddress,String password) async {
    try {
      connector.showLoading();
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      connector.hideLoading();
      connector.showMessage('message');
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseErrors.weakPassword) {
        connector.hideLoading();
        connector.showMessage('The password provided is too weak.');

      } else if (e.code == FireBaseErrors.emailAlreadyInUse) {
        connector.hideLoading();
        connector.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      connector.hideLoading();
      connector.showMessage(e.toString());
    }
  }
}