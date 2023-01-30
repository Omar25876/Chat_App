import 'package:chat/shared/styles/mytheme.dart';
import 'package:chat/ui/screens/home/home_screen.dart';
import 'package:chat/ui/screens/home/login/login_view.dart';
import 'package:chat/ui/screens/home/register/register_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.transparent,
      debugShowCheckedModeBanner: false,
      routes:
      {
        HomeScreen.routName:(context) => HomeScreen(),
        LoginView.routeName:(context) => LoginView(),
        RegisterView.routeName:(context) => RegisterView(),

      },
      initialRoute: LoginView.routeName,
      theme: MyTheme.Light,
      themeMode: ThemeMode.light,
    );
  }
}
