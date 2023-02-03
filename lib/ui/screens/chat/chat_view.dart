import 'package:chat/models/room_model.dart';
import 'package:chat/ui/screens/base.dart';
import 'package:chat/ui/screens/chat/chat_navigator.dart';
import 'package:chat/ui/screens/chat/chat_view_model.dart';
import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
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
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: "type a message",
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
                  SizedBox(
                    width: 6,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.sendMessage(messageController.text);
                      },
                      child: Row(
                        children: [
                          Text("Send"),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.send)
                        ],
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
