import 'package:chat/database_utils/database_utils.dart';
import 'package:chat/models/room_model.dart';
import 'package:chat/ui/screens/add_room/add_room_view.dart';
import 'package:chat/ui/screens/base.dart';
import 'package:chat/ui/screens/home/home_navigator.dart';
import 'package:chat/ui/screens/home/home_view_model.dart';
import 'package:chat/ui/screens/home/room_item.dart';
import 'package:chat/ui/screens/login/login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routName = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeViewModel>
    implements HomeNavigator {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }

  @override
  HomeViewModel initViewModel() {
    // TODO: implement initViewModel
    return HomeViewModel();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> viewModel,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage('assets/bg.png'),fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Chat',style: TextStyle(
              color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold,
            ),),
            centerTitle: true,
            elevation: 0.0,
            actions: [
              IconButton(onPressed: (){
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              }, icon: const Icon(Icons.logout,color: Colors.white,size: 40,),),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: (){
              Navigator.pushNamed(context, AddRoomView.routeName);
            },
            child: const Icon(Icons.add,size: 40,color: Colors.white,),
          ),
          body:Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 18,left: 18),
            child:StreamBuilder<QuerySnapshot<Room>>(
              stream: DataBaseUtils.getRoomsFromFirestore(),
              builder:(context,snapshot){
                if(snapshot.hasError){
                  return Center(child: Text('HomeView: ${snapshot.error.toString()}'));
                }
                else if(snapshot.hasData){
                 var rooms = snapshot.data!.docs.map((e) => e.data()).toList();
                  return  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      return RoomItem(rooms[index]);
                    },
                    itemCount: rooms.length,
                  );
                }
                else{
                  return const Center(child: CircularProgressIndicator());
                }
              } ,
            ),
          ),
        ),
      ),
    );
  }

}
