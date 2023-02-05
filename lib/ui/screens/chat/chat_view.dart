import 'package:chat/models/message_model.dart';
import 'package:chat/models/room_model.dart';
import 'package:chat/providers/provider.dart';
import 'package:chat/ui/screens/base.dart';
import 'package:chat/ui/screens/chat/chat_navigator.dart';
import 'package:chat/ui/screens/chat/chat_view_model.dart';
import 'package:chat/ui/screens/chat/message_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  static String routeName = "Chat View";

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseView<ChatView, ChatViewModel>
    implements ChatNavigator {

  var messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  ChatViewModel initViewModel() {
    // TODO: implement initViewModel
    return ChatViewModel();
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    var provider = Provider.of<MyProvider>(context);
    //viewModel.myUser = provider.myUser!;
    viewModel.room = room;
   // print('lol : ${provider.myUser!.name}');
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/bg.png'), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            '${room.roomName}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 8,
                blurRadius: 6,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.getMessages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("something went wrong"));
                      }
                      var messages =
                      snapshot.data?.docs.map((e) => e.data()).toList();

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return MessageWidget(messages![index]);
                        },
                        itemCount: messages?.length ?? 0,
                      );
                    },
                  ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: "Type a message",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 16
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                ),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2))),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          viewModel.sendMessage(messageController.text);

                        },
                        child: Row(
                          children: const [
                            Text("Send",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(Icons.send,color: Colors.white,)
                          ],
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void clearMessage() {
    // TODO: implement clearMessage
    messageController.clear();
  }
}
