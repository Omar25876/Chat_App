import 'package:chat/models/room_model.dart';
import 'package:chat/ui/screens/chat/chat_view.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  Room room;

  RoomItem(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatView.routeName, arguments: room);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset("assets/${room.catId}.jpeg")),
            const SizedBox(height: 10,),
            Text(room.roomName,style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
            ),),
          ],
        ),
      ),
    );
  }
}
