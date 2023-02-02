import 'package:chat/models/user_model.dart';
import 'package:chat/ui/screens/base.dart';

abstract class LoginNavigator implements BaseNavigator{

void goToHome(MyUser myUser);
}