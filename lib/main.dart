import 'package:chat/firebase_options.dart';
import 'package:chat/providers/provider.dart';
import 'package:chat/shared/styles/mytheme.dart';
import 'package:chat/ui/screens/add_room/add_room_view.dart';
import 'package:chat/ui/screens/home/home_view.dart';
import 'package:chat/ui/screens/login/login_view.dart';
import 'package:chat/ui/screens/register/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(ChangeNotifierProvider(
    create: (context)=>MyProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      color: Colors.transparent,
      debugShowCheckedModeBanner: false,
      routes:
      {
        HomeScreen.routName:(context) => HomeScreen(),
        RegisterView.routeName:(context) => RegisterView(),
        LoginView.routeName:(context) => LoginView(),
        AddRoomView.routeName : (context) => AddRoomView(),
      },
      initialRoute: provider.firebaseUser != null?HomeScreen.routName:LoginView.routeName,
      theme: MyTheme.Light,
      themeMode: ThemeMode.light,
    );
  }
}
