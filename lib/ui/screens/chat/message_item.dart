import 'package:chat/models/message_model.dart';
import 'package:chat/providers/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatefulWidget {
  Message message;

  MessageWidget(this.message);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!.uid == widget.message.senderId
        ? SenderMessage(widget.message)
        : ReciverMessage(widget.message);
  }
}

class SenderMessage extends StatelessWidget {
  Message message;

  SenderMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18))),
              child: Text(
                message.content,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              )),
          const SizedBox(height: 2,),
          Text(
            date.substring(12),
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class ReciverMessage extends StatelessWidget {
  Message message;

  ReciverMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18))),
              child: Text(
                message.content,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              )),
          const SizedBox(height: 2,),
          Text(
            date.substring(12),
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
