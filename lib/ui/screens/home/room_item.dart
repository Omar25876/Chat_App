import 'package:chat/models/room_model.dart';
import 'package:chat/ui/screens/chat/chat_view.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  Room room;
  RoomItem(this.room);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ChatView.routeName,arguments: room);
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              Container(
                width: 180,height:120,
                  padding: EdgeInsets.only(top: 12),
                  child: Image.asset('assets/${room.catId}.jpeg',)),
              Container(
                padding: EdgeInsets.only(top: 4,bottom: 4),
                margin: EdgeInsets.only(bottom: 1),
                child: Text("${room.roomName}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}