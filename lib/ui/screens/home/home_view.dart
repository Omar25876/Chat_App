import 'package:chat/ui/screens/add_room/add_room_view.dart';
import 'package:chat/ui/screens/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routName = 'Home Screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage('assets/bg.png'),fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Chat',style: TextStyle(
            color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold,
          ),),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, LoginView.routeName);
            }, icon: Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: (){
            Navigator.pushNamed(context, AddRoomView.routeName);
          },
          child: Icon(Icons.add,size: 40,color: Colors.white,),
        ),
        body:  Container(
          color: Colors.cyan,
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
