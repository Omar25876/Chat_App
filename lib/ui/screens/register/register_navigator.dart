import 'package:chat/models/user_model.dart';
import 'package:chat/ui/screens/base.dart';

abstract class RegisterNavigator implements BaseNavigator{

void goToHome(MyUser user);
}